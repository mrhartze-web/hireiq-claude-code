import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';
import '../../models/job_model.dart';
import '../../models/application_model.dart';
import '../../models/brief_model.dart';
import '../../models/placement_model.dart';
import '../../models/notification_model.dart';
import '../../models/message_model.dart';
import '../../models/candidate_model.dart';
import '../../models/employer_model.dart';
import '../../models/recruiter_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async =>
      await _db.collection('users').doc(user.uid).set(user.toJson());

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) return UserModel.fromJson(doc.data()!);
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> fields) async =>
      await _db.collection('users').doc(uid).update({
        ...fields, 'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<CandidateModel?> getCandidate(String uid) async {
    final doc = await _db.collection('candidates').doc(uid).get();
    if (doc.exists && doc.data() != null) return CandidateModel.fromJson(doc.data()!);
    return null;
  }

  Future<void> upsertCandidate(CandidateModel candidate) async =>
      await _db.collection('candidates').doc(candidate.uid)
          .set(candidate.toJson(), SetOptions(merge: true));

  Future<EmployerModel?> getEmployer(String uid) async {
    final doc = await _db.collection('employers').doc(uid).get();
    if (doc.exists && doc.data() != null) return EmployerModel.fromJson(doc.data()!);
    return null;
  }

  Future<void> upsertEmployer(EmployerModel employer) async =>
      await _db.collection('employers').doc(employer.uid)
          .set(employer.toJson(), SetOptions(merge: true));

  Future<RecruiterModel?> getRecruiter(String uid) async {
    final doc = await _db.collection('recruiters').doc(uid).get();
    if (doc.exists && doc.data() != null) return RecruiterModel.fromJson(doc.data()!);
    return null;
  }

  Future<void> upsertRecruiter(RecruiterModel recruiter) async =>
      await _db.collection('recruiters').doc(recruiter.uid)
          .set(recruiter.toJson(), SetOptions(merge: true));

  Future<String> createJob(JobModel job) async {
    final docRef = _db.collection('jobs').doc();
    await docRef.set(job.copyWith(jobId: docRef.id).toJson());
    return docRef.id;
  }

  Future<JobModel?> getJob(String jobId) async {
    final doc = await _db.collection('jobs').doc(jobId).get();
    if (doc.exists && doc.data() != null) return JobModel.fromJson(doc.data()!);
    return null;
  }

  Stream<List<JobModel>> getActiveJobs() => _db
      .collection('jobs')
      .where('isActive', isEqualTo: true)
      .orderBy('postedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => JobModel.fromJson(d.data())).toList());

  Stream<List<JobModel>> getEmployerJobs(String employerUid) => _db
      .collection('jobs')
      .where('employerUid', isEqualTo: employerUid)
      .orderBy('postedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => JobModel.fromJson(d.data())).toList());

  Future<void> updateJob(String jobId, Map<String, dynamic> fields) async =>
      await _db.collection('jobs').doc(jobId).update(fields);

  Future<void> deactivateJob(String jobId) async =>
      await _db.collection('jobs').doc(jobId).update({'isActive': false});

  Future<String> createApplication(ApplicationModel application) async {
    final docRef = _db.collection('applications').doc();
    await docRef.set(application.copyWith(applicationId: docRef.id).toJson());
    return docRef.id;
  }

  Stream<List<ApplicationModel>> getCandidateApplications(String candidateUid) => _db
      .collection('applications')
      .where('candidateUid', isEqualTo: candidateUid)
      .orderBy('appliedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => ApplicationModel.fromJson(d.data())).toList());

  Stream<List<ApplicationModel>> getJobApplications(String jobId) => _db
      .collection('applications')
      .where('jobId', isEqualTo: jobId)
      .orderBy('appliedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => ApplicationModel.fromJson(d.data())).toList());

  Future<void> updateApplicationStatus(String applicationId, String status) async =>
      await _db.collection('applications').doc(applicationId).update({
        'status': status, 'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<String> createBrief(BriefModel brief) async {
    final docRef = _db.collection('briefs').doc();
    await docRef.set(brief.copyWith(briefId: docRef.id).toJson());
    return docRef.id;
  }

  Stream<List<BriefModel>> getRecruiterBriefs(String recruiterUid) => _db
      .collection('briefs')
      .where('recruiterUid', isEqualTo: recruiterUid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => BriefModel.fromJson(d.data())).toList());

  Future<void> updateBrief(String briefId, Map<String, dynamic> fields) async =>
      await _db.collection('briefs').doc(briefId).update(fields);

  Future<String> createPlacement(PlacementModel placement) async {
    final docRef = _db.collection('placements').doc();
    await docRef.set(placement.copyWith(placementId: docRef.id).toJson());
    return docRef.id;
  }

  Stream<List<PlacementModel>> getRecruiterPlacements(String recruiterUid) => _db
      .collection('placements')
      .where('recruiterUid', isEqualTo: recruiterUid)
      .orderBy('placedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => PlacementModel.fromJson(d.data())).toList());

  Future<void> updatePaymentStatus(String placementId, String status) async =>
      await _db.collection('placements').doc(placementId)
          .update({'paymentStatus': status});

  Future<void> createNotification(NotificationModel notification) async {
    final docRef = _db.collection('notifications').doc();
    await docRef.set(notification.copyWith(notificationId: docRef.id).toJson());
  }

  Stream<List<NotificationModel>> getUserNotifications(String recipientUid) => _db
      .collection('notifications')
      .where('recipientUid', isEqualTo: recipientUid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => NotificationModel.fromJson(d.data())).toList());

  Future<void> markNotificationRead(String notificationId) async =>
      await _db.collection('notifications').doc(notificationId)
          .update({'isRead': true});

  Future<void> sendMessage(MessageModel message) async {
    final docRef = _db.collection('messages').doc();
    await docRef.set(message.copyWith(messageId: docRef.id).toJson());
  }

  Stream<List<MessageModel>> getConversation(String conversationId) => _db
      .collection('messages')
      .where('conversationId', isEqualTo: conversationId)
      .orderBy('sentAt', descending: false)
      .snapshots()
      .map((s) => s.docs.map((d) => MessageModel.fromJson(d.data())).toList());

  Future<void> markMessageRead(String messageId) async =>
      await _db.collection('messages').doc(messageId).update({'isRead': true});

  Stream<List<String>> getSavedJobIds(String uid) => _db
      .collection('users')
      .doc(uid)
      .collection('savedJobs')
      .orderBy('savedAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => d.id).toList());

  Future<void> saveJob(String uid, String jobId) async => await _db
      .collection('users')
      .doc(uid)
      .collection('savedJobs')
      .doc(jobId)
      .set({'savedAt': FieldValue.serverTimestamp()});

  Future<void> unsaveJob(String uid, String jobId) async => await _db
      .collection('users')
      .doc(uid)
      .collection('savedJobs')
      .doc(jobId)
      .delete();

  Future<bool> checkAlreadyApplied(String candidateUid, String jobId) async {
    final snap = await _db
        .collection('applications')
        .where('candidateUid', isEqualTo: candidateUid)
        .where('jobId', isEqualTo: jobId)
        .limit(1)
        .get();
    return snap.docs.isNotEmpty;
  }

  Future<String> submitApplication(ApplicationModel application) =>
      createApplication(application);

  Future<void> incrementApplicationsCount(String jobId) async =>
      await _db.collection('jobs').doc(jobId).update({
        'applicationsCount': FieldValue.increment(1),
      });
}
