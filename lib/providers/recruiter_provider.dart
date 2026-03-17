import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recruiter_model.dart';
import '../models/brief_model.dart';
import '../models/placement_model.dart';
import 'job_provider.dart';

final recruiterProfileProvider =
    FutureProvider.family<RecruiterModel?, String>((ref, uid) async =>
        ref.watch(firestoreServiceProvider).getRecruiter(uid));

final recruiterBriefsProvider =
    StreamProvider.family<List<BriefModel>, String>((ref, recruiterUid) =>
        ref.watch(firestoreServiceProvider).getRecruiterBriefs(recruiterUid));

final recruiterPlacementsProvider =
    StreamProvider.family<List<PlacementModel>, String>((ref, recruiterUid) =>
        ref.watch(firestoreServiceProvider).getRecruiterPlacements(recruiterUid));
