const functions = require('firebase-functions');
const admin = require('firebase-admin');
const Anthropic = require('@anthropic-ai/sdk');
admin.initializeApp();

const anthropicApiKey = process.env.ANTHROPIC_API_KEY;

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

  const { uid, documentType } = data;
  const db = admin.firestore();

  await db.collection('verifications').add({
    candidateUid: uid,
    documentType: documentType || 'sa_id',
    status: 'pending',
    requestedAt: admin.firestore.FieldValue.serverTimestamp(),
    note: 'DHA API integration pending',
  });

  await db.collection('candidates').doc(uid).update({
    passportIQStatus: 'pending',
    passportIQRequestedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  await db.collection('notifications').add({
    recipientUid: uid,
    title: 'PassportIQ verification submitted',
    body: 'Your identity verification is being processed. This usually takes 24 hours.',
    type: 'passportiq',
    isRead: false,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    actionRoute: '/candidate/passport-iq',
  });

  return {
    status: 'pending',
    message: 'Verification submitted successfully',
    estimatedTime: '24 hours',
  };
});

// ── signalIQ ───────────────────────────────────────────────────────────────────

exports.signalIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { industry, location, role } = data;
  const db = admin.firestore();

  const jobsSnap = await db.collection('jobs')
    .where('isActive', '==', true)
    .get();

  const jobs = jobsSnap.docs.map(d => d.data());

  const relevant = jobs.filter(j => {
    const matchIndustry = !industry ||
      (j.industry || '').toLowerCase().includes(industry.toLowerCase());
    const matchLocation = !location ||
      (j.location || '').toLowerCase().includes(location.toLowerCase());
    return matchIndustry && matchLocation;
  });

  const salaries = relevant
    .filter(j => j.salaryMin > 0 && j.salaryMax > 0)
    .map(j => Math.round((j.salaryMin + j.salaryMax) / 2));

  const sorted = salaries.sort((a, b) => a - b);
  const len = sorted.length;

  const benchmark = {
    min: len > 0 ? sorted[0] : 0,
    median: len > 0 ? sorted[Math.floor(len / 2)] : 0,
    max: len > 0 ? sorted[len - 1] : 0,
    average: len > 0 ? Math.round(sorted.reduce((a, b) => a + b, 0) / len) : 0,
    sampleSize: len,
    industry: industry || 'All industries',
    location: location || 'South Africa',
    lastUpdated: new Date().toISOString(),
  };

  const demandIndicator = relevant.length > 20 ? 'HIGH'
    : relevant.length > 10 ? 'MEDIUM' : 'LOW';

  return {
    benchmark,
    demandIndicator,
    activeRoles: relevant.length,
    totalRolesAnalysed: jobs.length,
  };
});

// ── forgeIQ ────────────────────────────────────────────────────────────────────

exports.forgeIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { jobId, type = 'cv' } = data;
  const candidateUid = context.auth.uid;

  if (!anthropicApiKey) {
    throw new functions.https.HttpsError(
      'failed-precondition', 'Anthropic API key not configured'
    );
  }

  const db = admin.firestore();

  // Fetch candidate profile
  const candidateSnap = await db.collection('candidates').doc(candidateUid).get();
  if (!candidateSnap.exists) {
    throw new functions.https.HttpsError('not-found', 'Candidate profile not found');
  }
  const candidate = candidateSnap.data();

  // Optionally fetch target job
  let job = null;
  if (jobId) {
    const jobSnap = await db.collection('jobs').doc(jobId).get();
    if (jobSnap.exists) job = jobSnap.data();
  }

  // Build context strings
  const candidateContext = `
Name: ${candidate.fullName || candidate.name || 'Candidate'}
Current Role: ${candidate.currentRole || 'Not specified'}
Years of Experience: ${candidate.yearsExperience || 0}
Location: ${candidate.location || 'Not specified'}
Skills: ${(candidate.skills || []).join(', ') || 'Not specified'}
Education: ${candidate.education || 'Not specified'}
Bio: ${candidate.bio || candidate.summary || 'Not specified'}
`.trim();

  const jobContext = job
    ? `
Target Role: ${job.title || 'Not specified'}
Company: ${job.company || 'Not specified'}
Required Skills: ${(job.skills || []).join(', ') || 'Not specified'}
Experience Level: ${job.experienceLevel || 'Not specified'}
Description: ${(job.description || '').slice(0, 600)}
`.trim()
    : '';

  let prompt;
  if (type === 'cover_letter') {
    prompt = `You are an expert career coach. Write a professional cover letter for the following candidate${job ? ' applying for the specified role' : ''}.

CANDIDATE PROFILE:
${candidateContext}
${jobContext ? `\nTARGET ROLE:\n${jobContext}` : ''}

Write a compelling, ATS-optimised cover letter. Use a professional tone. Keep it to 3–4 paragraphs. Do not use placeholder text like [Your Name].`;
  } else {
    prompt = `You are an expert CV writer and career coach. Generate a professional, ATS-optimised CV for the following candidate${job ? ' tailored for the target role' : ''}.

CANDIDATE PROFILE:
${candidateContext}
${jobContext ? `\nTARGET ROLE:\n${jobContext}` : ''}

Format the CV with these ALL CAPS section headers on their own lines:
PROFESSIONAL SUMMARY
EXPERIENCE
EDUCATION
SKILLS
CERTIFICATIONS (only if relevant)

Under each section write well-structured, achievement-focused content. Use metrics where possible. Do not include placeholder text.`;
  }

  const anthropic = new Anthropic({ apiKey: anthropicApiKey });

  const message = await anthropic.messages.create({
    model: 'claude-sonnet-4-20250514',
    max_tokens: 1500,
    messages: [{ role: 'user', content: prompt }],
  });

  const content = message.content[0]?.text || '';
  const generatedAt = admin.firestore.FieldValue.serverTimestamp();

  // Store in generated_cvs collection
  const cvRef = await db.collection('generated_cvs').add({
    candidateUid,
    jobId: jobId || null,
    type,
    content,
    generatedAt,
  });

  // Update candidate doc
  await db.collection('candidates').doc(candidateUid).update({
    hasGeneratedCV: true,
    lastCVGeneratedAt: generatedAt,
    updatedAt: generatedAt,
  });

  return { cvId: cvRef.id, content, generatedAt: new Date().toISOString() };
});

// ── wildcardIQ ─────────────────────────────────────────────────────────────────

exports.wildcardIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { jobId } = data;
  const db = admin.firestore();

  const appsSnap = await db.collection('applications')
    .where('jobId', '==', jobId)
    .where('status', '==', 'applied')
    .get();

  const applications = appsSnap.docs.map(d => ({ id: d.id, ...d.data() }));

  const blindCandidates = await Promise.all(
    applications.map(async (app) => {
      const candSnap = await db.collection('candidates').doc(app.candidateUid).get();
      if (!candSnap.exists) return null;
      const candidate = candSnap.data();
      return {
        applicationId: app.id,
        matchIQScore: app.matchIQScore || 0,
        skills: candidate.skills || [],
        yearsExperience: candidate.yearsExperience || 0,
        profileCompleteness: candidate.profileCompletionPercent || 0,
        passportIQVerified: candidate.passportIQStatus === 'verified',
      };
    })
  );

  const filtered = blindCandidates
    .filter(Boolean)
    .sort((a, b) => b.matchIQScore - a.matchIQScore);

  return {
    jobId,
    totalCandidates: filtered.length,
    blindCandidates: filtered,
    biasRemovedFields: ['name', 'photo', 'location', 'age', 'gender'],
  };
});

// ── upliftIQ ───────────────────────────────────────────────────────────────────

exports.upliftIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { uid, targetRole } = data;
  const db = admin.firestore();

  const candidateSnap = await db.collection('candidates').doc(uid).get();
  if (!candidateSnap.exists) {
    throw new functions.https.HttpsError('not-found', 'Candidate not found');
  }

  const candidate = candidateSnap.data();
  const currentSkills = (candidate.skills || []).map(s => s.toLowerCase());

  const roleSkillMap = {
    'flutter developer': ['flutter', 'dart', 'firebase', 'riverpod', 'gorouter', 'rest api', 'git'],
    'react developer': ['react', 'javascript', 'typescript', 'css', 'html', 'node.js', 'git'],
    'data engineer': ['python', 'sql', 'spark', 'airflow', 'aws', 'dbt', 'git'],
    'product manager': ['product strategy', 'agile', 'jira', 'user research', 'analytics', 'roadmapping'],
    'financial accountant': ['ifrs', 'gaap', 'excel', 'sap', 'financial reporting', 'tax', 'audit'],
    'project manager': ['pmp', 'agile', 'ms project', 'risk management', 'stakeholder management', 'budget management'],
    'hr manager': ['recruitment', 'performance management', 'labour law', 'sabpp', 'payroll', 'employee relations', 'training'],
    'data analyst': ['sql', 'python', 'excel', 'power bi', 'tableau', 'statistics', 'data visualisation'],
    'ux designer': ['figma', 'user research', 'prototyping', 'wireframing', 'usability testing', 'design systems', 'accessibility'],
    'devops engineer': ['docker', 'kubernetes', 'ci/cd', 'aws', 'terraform', 'linux', 'monitoring'],
  };

  const targetKey = (targetRole || '').toLowerCase();
  const requiredSkills = roleSkillMap[targetKey] || [];

  const skillGaps = requiredSkills.filter(skill =>
    !currentSkills.some(cs => cs.includes(skill) || skill.includes(cs))
  );

  const learningPath = skillGaps.map((skill, index) => ({
    week: (index + 1) * 2,
    skill,
    resource: `Search "${skill} course South Africa" on GetSmarter or Coursera`,
    estimatedHours: 8,
    priority: index < 3 ? 'HIGH' : 'MEDIUM',
  }));

  await db.collection('roadmaps').doc(uid).set({
    candidateUid: uid,
    targetRole,
    currentSkills,
    skillGaps,
    learningPath,
    generatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return {
    currentSkills,
    targetRole,
    skillGaps,
    learningPath,
    estimatedWeeks: skillGaps.length * 2,
    completionScore: requiredSkills.length > 0
      ? Math.round(((requiredSkills.length - skillGaps.length) / requiredSkills.length) * 100)
      : 100,
  };
});

// ── shieldIQ ───────────────────────────────────────────────────────────────────

exports.shieldIQ = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { targetUid, targetType, targetId } = data;
  const db = admin.firestore();

  let riskScore = 0;
  const flags = [];

  if (targetType === 'candidate') {
    const candSnap = await db.collection('candidates').doc(targetUid).get();

    if (candSnap.exists) {
      const candidate = candSnap.data();

      if ((candidate.profileCompletionPercent || 0) < 30) {
        riskScore += 20;
        flags.push('Incomplete profile');
      }

      if (candidate.passportIQStatus !== 'verified') {
        riskScore += 15;
        flags.push('Identity not verified');
      }

      if ((candidate.skills || []).length > 30) {
        riskScore += 25;
        flags.push('Unusually high skill count');
      }

      const recentApps = await db.collection('applications')
        .where('candidateUid', '==', targetUid)
        .get();

      if (recentApps.size > 50) {
        riskScore += 20;
        flags.push('High application volume');
      }
    }
  }

  const riskLevel = riskScore >= 50 ? 'HIGH'
    : riskScore >= 25 ? 'MEDIUM' : 'LOW';

  await db.collection('shield_checks').add({
    targetUid,
    targetType,
    targetId: targetId || null,
    riskScore,
    riskLevel,
    flags,
    checkedAt: admin.firestore.FieldValue.serverTimestamp(),
    checkedBy: context.auth.uid,
  });

  return { riskScore, riskLevel, flags };
});

// ── sendNotification ───────────────────────────────────────────────────────────

exports.sendNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { recipientUid, title, body, actionRoute } = data;
  const db = admin.firestore();
  const messaging = admin.messaging();

  // Get recipient FCM token
  const userSnap = await db.collection('users').doc(recipientUid).get();
  if (!userSnap.exists) return { sent: false };

  const fcmToken = userSnap.data().fcmToken;

  // Store notification in Firestore
  await db.collection('notifications').add({
    recipientUid,
    title,
    body,
    type: 'general',
    isRead: false,
    actionRoute: actionRoute || null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Send FCM push if token exists
  if (fcmToken) {
    try {
      await messaging.send({
        token: fcmToken,
        notification: { title, body },
        data: {
          actionRoute: actionRoute || '',
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
        android: {
          notification: {
            channelId: 'hireiq_channel',
            priority: 'high',
          },
        },
      });
      return { sent: true, method: 'fcm' };
    } catch (e) {
      console.error('FCM send failed:', e);
      return { sent: true, method: 'firestore_only' };
    }
  }

  return { sent: true, method: 'firestore_only' };
});
