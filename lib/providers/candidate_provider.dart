import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/candidate_model.dart';
import 'job_provider.dart';

final candidateProfileProvider =
    FutureProvider.family<CandidateModel?, String>((ref, uid) async =>
        ref.watch(firestoreServiceProvider).getCandidate(uid));
