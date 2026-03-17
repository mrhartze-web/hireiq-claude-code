import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String conversationId;
  final String senderUid;
  final String recipientUid;
  final String body;
  final DateTime sentAt;
  final bool isRead;
  final String? attachmentUrl;

  const MessageModel({
    required this.messageId, required this.conversationId,
    required this.senderUid, required this.recipientUid,
    required this.body, required this.sentAt, required this.isRead,
    this.attachmentUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json['messageId'] as String? ?? '',
        conversationId: json['conversationId'] as String? ?? '',
        senderUid: json['senderUid'] as String? ?? '',
        recipientUid: json['recipientUid'] as String? ?? '',
        body: json['body'] as String? ?? '',
        sentAt: (json['sentAt'] is Timestamp)
            ? (json['sentAt'] as Timestamp).toDate()
            : DateTime.now(),
        isRead: json['isRead'] as bool? ?? false,
        attachmentUrl: json['attachmentUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'messageId': messageId, 'conversationId': conversationId,
        'senderUid': senderUid, 'recipientUid': recipientUid,
        'body': body, 'sentAt': Timestamp.fromDate(sentAt),
        'isRead': isRead, 'attachmentUrl': attachmentUrl,
      };

  MessageModel copyWith({
    String? messageId, String? conversationId, String? senderUid,
    String? recipientUid, String? body, DateTime? sentAt,
    bool? isRead, String? attachmentUrl,
  }) => MessageModel(
        messageId: messageId ?? this.messageId,
        conversationId: conversationId ?? this.conversationId,
        senderUid: senderUid ?? this.senderUid,
        recipientUid: recipientUid ?? this.recipientUid,
        body: body ?? this.body, sentAt: sentAt ?? this.sentAt,
        isRead: isRead ?? this.isRead,
        attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      );
}
