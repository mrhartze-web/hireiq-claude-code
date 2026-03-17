import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase/firestore_service.dart';
import '../models/job_model.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) =>
    FirestoreService());

final activeJobsProvider = StreamProvider<List<JobModel>>((ref) =>
    ref.watch(firestoreServiceProvider).getActiveJobs());

final employerJobsProvider =
    StreamProvider.family<List<JobModel>, String>((ref, employerUid) =>
        ref.watch(firestoreServiceProvider).getEmployerJobs(employerUid));

class JobSearchNotifier extends StateNotifier<List<JobModel>> {
  final FirestoreService _service;
  JobSearchNotifier(this._service) : super([]);

  Future<void> search(String keyword) async {
    // TODO: implement search via Algolia or Firestore
    state = [];
  }

  void clear() => state = [];
}

final jobSearchProvider =
    StateNotifierProvider<JobSearchNotifier, List<JobModel>>((ref) =>
        JobSearchNotifier(ref.watch(firestoreServiceProvider)));
