import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String recipientUid;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final String? actionRoute;

  const NotificationModel({
    required this.notificationId, required this.recipientUid,
    required this.title, required this.body, required this.type,
    required this.isRead, required this.createdAt, this.actionRoute,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notificationId: json['notificationId'] as String? ?? '',
        recipientUid: json['recipientUid'] as String? ?? '',
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        type: json['type'] as String? ?? 'general',
        isRead: json['isRead'] as bool? ?? false,
        createdAt: (json['createdAt'] is Timestamp)
            ? (json['createdAt'] as Timestamp).toDate()
            : DateTime.now(),
        actionRoute: json['actionRoute'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId, 'recipientUid': recipientUid,
        'title': title, 'body': body, 'type': type, 'isRead': isRead,
        'createdAt': Timestamp.fromDate(createdAt), 'actionRoute': actionRoute,
      };

  NotificationModel copyWith({
    String? notificationId, String? recipientUid, String? title,
    String? body, String? type, bool? isRead, DateTime? createdAt,
    String? actionRoute,
  }) => NotificationModel(
        notificationId: notificationId ?? this.notificationId,
        recipientUid: recipientUid ?? this.recipientUid,
        title: title ?? this.title, body: body ?? this.body,
        type: type ?? this.type, isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        actionRoute: actionRoute ?? this.actionRoute,
      );
}
