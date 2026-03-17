import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';
import 'job_provider.dart';

final notificationsProvider =
    StreamProvider.family<List<NotificationModel>, String>((ref, recipientUid) =>
        ref.watch(firestoreServiceProvider).getUserNotifications(recipientUid));
