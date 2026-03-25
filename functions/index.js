const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// ── Shared scoring helper ──────────────────────────────────────────────────────

function computeMatchIQScore(job, candidate) {
  // 1. SKILLS MATCH — 35 points
  const jobSkills = (job.skills || []).map(s => s.toLowerCase().trim());
  const candidateSkills = (candidate.skills || []).map(s => s.toLowerCase().trim());

  let skillMatches = 0;
  jobSkills.forEach(skill => {
    if (candidateSkills.some(cs => cs.includes(skill) || skill.includes(cs))) {
      skillMatches++;
    }
  });
  const skillScore = jobSkills.length > 0
    ? Math.round((skillMatches / jobSkills.length) * 35)
    : 17;

  // 2. EXPERIENCE MATCH — 25 points
  const jobLevel = (job.experienceLevel || '').toLowerCase();
  const candidateYears = candidate.yearsExperience || 0;

  let experienceScore = 17;
  if (jobLevel.includes('junior') || jobLevel.includes('entry')) {
    experienceScore = candidateYears <= 3 ? 25 : candidateYears <= 5 ? 18 : 10;
  } else if (jobLevel.includes('mid')) {
    experienceScore = (candidateYears >= 3 && candidateYears <= 7) ? 25
      : candidateYears >= 2 ? 18 : 10;
  } else if (jobLevel.includes('senior')) {
    experienceScore = candidateYears >= 5 ? 25 : candidateYears >= 3 ? 18 : 8;
  } else if (jobLevel.includes('lead') || jobLevel.includes('executive')) {
    experienceScore = candidateYears >= 8 ? 25 : candidateYears >= 5 ? 18 : 10;
  }

  // 3. LOCATION MATCH — 20 points
  const jobLocation = (job.location || '').toLowerCase();
  const candidateLocation = (candidate.location || '').toLowerCase();
  const isRemote = jobLocation.includes('remote');

  let locationScore = 8;
  if (isRemote) {
    locationScore = 20;
  } else if (candidateLocation && jobLocation &&
    (jobLocation.includes(candidateLocation.split(',')[0]) ||
     candidateLocation.includes(jobLocation.split(',')[0]))) {
    locationScore = 20;
  } else if (
    (candidateLocation.includes('johannesburg') && jobLocation.includes('gauteng')) ||
    (candidateLocation.includes('gauteng') && jobLocation.includes('johannesburg'))
  ) {
    locationScore = 18;
  }

  // 4. SALARY MATCH — 12 points
  const candidateSalary = candidate.salaryExpectation || 0;
  const jobMin = job.salaryMin || 0;
  const jobMax = job.salaryMax || 0;

  let salaryScore = 8;
  if (candidateSalary === 0 || (jobMin === 0 && jobMax === 0)) {
    salaryScore = 8;
  } else if (candidateSalary >= jobMin && candidateSalary <= jobMax) {
    salaryScore = 12;
  } else if (candidateSalary < jobMin * 1.1 || candidateSalary > jobMax * 0.9) {
    salaryScore = 8;
  } else {
    salaryScore = 4;
  }

  // 5. PROFILE COMPLETENESS — 8 points
  const completeness = candidate.profileCompletionPercent || 0;
  const completenessScore = Math.round((completeness / 100) * 8);

  const totalScore = Math.min(100,
    skillScore + experienceScore + locationScore + salaryScore + completenessScore
  );

  return {
    skillsMatch: skillScore,
    experienceMatch: experienceScore,
    locationMatch: locationScore,
    salaryMatch: salaryScore,
    profileCompleteness: completenessScore,
    totalScore,
    skillsMatched: skillMatches,
    totalSkillsRequired: jobSkills.length,
  };
}

// ── matchIQ — https callable ───────────────────────────────────────────────────

exports.matchIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { jobId, candidateUid } = data;
  if (!jobId || !candidateUid) {
    throw new functions.https.HttpsError(
      'invalid-argument', 'jobId and candidateUid required'
    );
  }

  const db = admin.firestore();

  const [jobSnap, candidateSnap] = await Promise.all([
    db.collection('jobs').doc(jobId).get(),
    db.collection('candidates').doc(candidateUid).get(),
  ]);

  if (!jobSnap.exists || !candidateSnap.exists) {
    throw new functions.https.HttpsError('not-found', 'Job or candidate not found');
  }

  const breakdown = computeMatchIQScore(jobSnap.data(), candidateSnap.data());
  const { totalScore } = breakdown;

  // Update application record if one exists
  const applicationSnap = await db.collection('applications')
    .where('jobId', '==', jobId)
    .where('candidateUid', '==', candidateUid)
    .limit(1)
    .get();

  if (!applicationSnap.empty) {
    await applicationSnap.docs[0].ref.update({
      matchIQScore: totalScore,
      matchIQBreakdown: breakdown,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  await db.collection('candidates').doc(candidateUid).update({
    matchIQScore: totalScore,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { score: totalScore, breakdown };
});

// ── onApplicationCreated — Firestore trigger (v7 API) ─────────────────────────

exports.onApplicationCreated = functions.firestore
  .onDocumentCreated('applications/{applicationId}', async (event) => {
    const snap = event.data;
    if (!snap) return null;

    const application = snap.data();
    const { jobId, candidateUid } = application;

    try {
      const db = admin.firestore();

      const [jobSnap, candidateSnap] = await Promise.all([
        db.collection('jobs').doc(jobId).get(),
        db.collection('candidates').doc(candidateUid).get(),
      ]);

      if (!jobSnap.exists || !candidateSnap.exists) return null;

      const job = jobSnap.data();
      const breakdown = computeMatchIQScore(job, candidateSnap.data());
      const { totalScore } = breakdown;

      await snap.ref.update({
        matchIQScore: totalScore,
        matchIQBreakdown: breakdown,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      await db.collection('candidates').doc(candidateUid).update({
        matchIQScore: totalScore,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      await db.collection('notifications').add({
        recipientUid: candidateUid,
        title: 'Your MatchIQ score is ready',
        body: `You scored ${totalScore}% match for ${job.title || 'this role'} at ${job.company || 'this company'}`,
        type: 'matchiq',
        isRead: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        actionRoute: '/candidate/applications',
      });

    } catch (error) {
      console.error('MatchIQ scoring error:', error);
    }

    return null;
  });

// ── onPlacementCreated — Firestore trigger ────────────────────────────────────

exports.onPlacementCreated = functions.firestore
  .onDocumentCreated('placements/{placementId}', async (event) => {
    const snap = event.data;
    if (!snap) return null;

    const placement = snap.data();
    const db = admin.firestore();

    try {
      const notifications = [];

      if (placement.recruiterUid) {
        notifications.push(db.collection('notifications').add({
          recipientUid: placement.recruiterUid,
          title: 'Placement confirmed',
          body: `Your placement for ${placement.candidateName || 'a candidate'} has been confirmed.`,
          type: 'placement',
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          actionRoute: '/recruiter/placements',
        }));
      }

      if (placement.employerUid) {
        notifications.push(db.collection('notifications').add({
          recipientUid: placement.employerUid,
          title: 'New placement confirmed',
          body: 'A candidate has been placed for your role.',
          type: 'placement',
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          actionRoute: '/employer/team',
        }));
      }

      await Promise.all(notifications);
    } catch (error) {
      console.error('onPlacementCreated error:', error);
    }

    return null;
  });

// ── passportIQ ─────────────────────────────────────────────────────────────────

exports.passportIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  return { verified: false, message: 'Verification pending API integration' };
});

// ── signalIQ ───────────────────────────────────────────────────────────────────

exports.signalIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  return {
    salaryBenchmark: { min: 20000, median: 40000, max: 70000 },
    talentAvailability: 'High',
  };
});

// ── forgeIQ ────────────────────────────────────────────────────────────────────

exports.forgeIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  return {
    optimisedCV: 'Placeholder CV string',
    suggestions: ['Add more metrics', 'Highlight leadership'],
  };
});

// ── wildcardIQ ─────────────────────────────────────────────────────────────────

exports.wildcardIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  return { wildcardCandidates: [] };
});

// ── upliftIQ ───────────────────────────────────────────────────────────────────

exports.upliftIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  return {
    skillGaps: ['React', 'NodeJS'],
    learningPath: ['Course 1', 'Course 2'],
  };
});

// ── sendNotification ───────────────────────────────────────────────────────────

exports.sendNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }
  const { recipientUid, title, body, actionRoute } = data;
  await admin.firestore().collection('notifications').add({
    recipientUid, title, body, actionRoute,
    isRead: false,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  return { success: true };
});
