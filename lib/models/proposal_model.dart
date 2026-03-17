import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalModel {
  final String id;
  final String gigId;
  final String freelancerId;
  final String employerId;
  final double price;
  final String timeline;
  final String approach;
  final String status; // pending, accepted, declined
  final DateTime submittedAt;

  ProposalModel({
    required this.id,
    required this.gigId,
    required this.freelancerId,
    required this.employerId,
    required this.price,
    required this.timeline,
    required this.approach,
    required this.status,
    required this.submittedAt,
  });

  factory ProposalModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProposalModel(
      id: doc.id,
      gigId: data['gigId'] ?? '',
      freelancerId: data['freelancerId'] ?? '',
      employerId: data['employerId'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      timeline: data['timeline'] ?? '',
      approach: data['approach'] ?? '',
      status: data['status'] ?? 'pending',
      submittedAt: (data['submittedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'gigId': gigId,
      'freelancerId': freelancerId,
      'employerId': employerId,
      'price': price,
      'timeline': timeline,
      'approach': approach,
      'status': status,
      'submittedAt': Timestamp.fromDate(submittedAt),
    };
  }

  ProposalModel copyWith({
    String? gigId,
    String? freelancerId,
    String? employerId,
    double? price,
    String? timeline,
    String? approach,
    String? status,
    DateTime? submittedAt,
  }) {
    return ProposalModel(
      id: id,
      gigId: gigId ?? this.gigId,
      freelancerId: freelancerId ?? this.freelancerId,
      employerId: employerId ?? this.employerId,
      price: price ?? this.price,
      timeline: timeline ?? this.timeline,
      approach: approach ?? this.approach,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }
}
