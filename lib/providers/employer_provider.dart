import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employer_model.dart';
import 'job_provider.dart';

final employerProfileProvider =
    FutureProvider.family<EmployerModel?, String>((ref, uid) async =>
        ref.watch(firestoreServiceProvider).getEmployer(uid));
