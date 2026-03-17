import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String applicationId;
  final String jobId;
  final String candidateUid;
  final String employerUid;
  final String status;
  final DateTime appliedAt;
  final DateTime updatedAt;
  final double? matchIQScore;
  final String? coverNote;
  final String? recruiterUid;

  const ApplicationModel({
    required this.applicationId, required this.jobId,
    required this.candidateUid, required this.employerUid,
    required this.status, required this.appliedAt, required this.updatedAt,
    this.matchIQScore, this.coverNote, this.recruiterUid,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => ApplicationModel(
        applicationId: json['applicationId'] as String? ?? '',
        jobId: json['jobId'] as String? ?? '',
        candidateUid: json['candidateUid'] as String? ?? '',
        employerUid: json['employerUid'] as String? ?? '',
        status: json['status'] as String? ?? 'applied',
        appliedAt: (json['appliedAt'] is Timestamp)
            ? (json['appliedAt'] as Timestamp).toDate()
            : DateTime.now(),
        updatedAt: (json['updatedAt'] is Timestamp)
            ? (json['updatedAt'] as Timestamp).toDate()
            : DateTime.now(),
        matchIQScore: (json['matchIQScore'] as num?)?.toDouble(),
        coverNote: json['coverNote'] as String?,
        recruiterUid: json['recruiterUid'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'applicationId': applicationId, 'jobId': jobId,
        'candidateUid': candidateUid, 'employerUid': employerUid,
        'status': status,
        'appliedAt': Timestamp.fromDate(appliedAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'matchIQScore': matchIQScore, 'coverNote': coverNote,
        'recruiterUid': recruiterUid,
      };

  ApplicationModel copyWith({
    String? applicationId, String? jobId, String? candidateUid,
    String? employerUid, String? status, DateTime? appliedAt,
    DateTime? updatedAt, double? matchIQScore, String? coverNote,
    String? recruiterUid,
  }) => ApplicationModel(
        applicationId: applicationId ?? this.applicationId,
        jobId: jobId ?? this.jobId,
        candidateUid: candidateUid ?? this.candidateUid,
        employerUid: employerUid ?? this.employerUid,
        status: status ?? this.status,
        appliedAt: appliedAt ?? this.appliedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        matchIQScore: matchIQScore ?? this.matchIQScore,
        coverNote: coverNote ?? this.coverNote,
        recruiterUid: recruiterUid ?? this.recruiterUid,
      );
}
