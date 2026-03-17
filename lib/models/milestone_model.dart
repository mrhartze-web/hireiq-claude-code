import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneModel {
  final String id;
  final String gigId;
  final String proposalId;
  final String description;
  final double amount;
  final String escrowStatus; // held, released, refunded
  final DateTime? completedAt;
  final DateTime? approvedAt;
  final String disputeReason;

  MilestoneModel({
    required this.id,
    required this.gigId,
    required this.proposalId,
    required this.description,
    required this.amount,
    required this.escrowStatus,
    this.completedAt,
    this.approvedAt,
    required this.disputeReason,
  });

  factory MilestoneModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MilestoneModel(
      id: doc.id,
      gigId: data['gigId'] ?? '',
      proposalId: data['proposalId'] ?? '',
      description: data['description'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      escrowStatus: data['escrowStatus'] ?? 'held',
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      approvedAt: data['approvedAt'] != null
          ? (data['approvedAt'] as Timestamp).toDate()
          : null,
      disputeReason: data['disputeReason'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'gigId': gigId,
      'proposalId': proposalId,
      'description': description,
      'amount': amount,
      'escrowStatus': escrowStatus,
      'completedAt':
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'approvedAt': approvedAt != null ? Timestamp.fromDate(approvedAt!) : null,
      'disputeReason': disputeReason,
    };
  }

  MilestoneModel copyWith({
    String? gigId,
    String? proposalId,
    String? description,
    double? amount,
    String? escrowStatus,
    DateTime? completedAt,
    DateTime? approvedAt,
    String? disputeReason,
  }) {
    return MilestoneModel(
      id: id,
      gigId: gigId ?? this.gigId,
      proposalId: proposalId ?? this.proposalId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      escrowStatus: escrowStatus ?? this.escrowStatus,
      completedAt: completedAt ?? this.completedAt,
      approvedAt: approvedAt ?? this.approvedAt,
      disputeReason: disputeReason ?? this.disputeReason,
    );
  }
}
