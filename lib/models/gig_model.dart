import 'package:cloud_firestore/cloud_firestore.dart';

class GigModel {
  final String id;
  final String employerId;
  final String title;
  final String description;
  final double budget;
  final List<String> skills;
  final DateTime deadline;
  final String status; // open, in_progress, completed, cancelled
  final int proposalCount;
  final List<Map<String, dynamic>> milestones;

  GigModel({
    required this.id,
    required this.employerId,
    required this.title,
    required this.description,
    required this.budget,
    required this.skills,
    required this.deadline,
    required this.status,
    required this.proposalCount,
    required this.milestones,
  });

  factory GigModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GigModel(
      id: doc.id,
      employerId: data['employerId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      budget: (data['budget'] ?? 0).toDouble(),
      skills: List<String>.from(data['skills'] ?? []),
      deadline: (data['deadline'] as Timestamp).toDate(),
      status: data['status'] ?? 'open',
      proposalCount: data['proposalCount'] ?? 0,
      milestones: List<Map<String, dynamic>>.from(data['milestones'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'employerId': employerId,
      'title': title,
      'description': description,
      'budget': budget,
      'skills': skills,
      'deadline': Timestamp.fromDate(deadline),
      'status': status,
      'proposalCount': proposalCount,
      'milestones': milestones,
    };
  }

  GigModel copyWith({
    String? employerId,
    String? title,
    String? description,
    double? budget,
    List<String>? skills,
    DateTime? deadline,
    String? status,
    int? proposalCount,
    List<Map<String, dynamic>>? milestones,
  }) {
    return GigModel(
      id: id,
      employerId: employerId ?? this.employerId,
      title: title ?? this.title,
      description: description ?? this.description,
      budget: budget ?? this.budget,
      skills: skills ?? this.skills,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      proposalCount: proposalCount ?? this.proposalCount,
      milestones: milestones ?? this.milestones,
    );
  }
}
