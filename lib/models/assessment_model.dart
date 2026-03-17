import 'package:cloud_firestore/cloud_firestore.dart';

class AssessmentModel {
  final String id;
  final String candidateId;
  final String type;
  final double score;
  final DateTime completedAt;
  final DateTime expiresAt;
  final String skillArea;
  final bool proctored;

  AssessmentModel({
    required this.id,
    required this.candidateId,
    required this.type,
    required this.score,
    required this.completedAt,
    required this.expiresAt,
    required this.skillArea,
    required this.proctored,
  });

  factory AssessmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AssessmentModel(
      id: doc.id,
      candidateId: data['candidateId'] ?? '',
      type: data['type'] ?? '',
      score: (data['score'] ?? 0).toDouble(),
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      expiresAt: (data['expiresAt'] as Timestamp).toDate(),
      skillArea: data['skillArea'] ?? '',
      proctored: data['proctored'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'candidateId': candidateId,
      'type': type,
      'score': score,
      'completedAt': Timestamp.fromDate(completedAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'skillArea': skillArea,
      'proctored': proctored,
    };
  }

  AssessmentModel copyWith({
    String? candidateId,
    String? type,
    double? score,
    DateTime? completedAt,
    DateTime? expiresAt,
    String? skillArea,
    bool? proctored,
  }) {
    return AssessmentModel(
      id: id,
      candidateId: candidateId ?? this.candidateId,
      type: type ?? this.type,
      score: score ?? this.score,
      completedAt: completedAt ?? this.completedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      skillArea: skillArea ?? this.skillArea,
      proctored: proctored ?? this.proctored,
    );
  }
}
