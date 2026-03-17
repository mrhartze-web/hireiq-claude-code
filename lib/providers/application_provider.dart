import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/application_model.dart';
import 'job_provider.dart';

final candidateApplicationsProvider =
    StreamProvider.family<List<ApplicationModel>, String>((ref, candidateUid) =>
        ref.watch(firestoreServiceProvider).getCandidateApplications(candidateUid));

final jobApplicationsProvider =
    StreamProvider.family<List<ApplicationModel>, String>((ref, jobId) =>
        ref.watch(firestoreServiceProvider).getJobApplications(jobId));
