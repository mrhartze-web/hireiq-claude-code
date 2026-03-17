import 'package:cloud_firestore/cloud_firestore.dart';

class BriefModel {
  final String briefId;
  final String recruiterUid;
  final String employerUid;
  final String roleName;
  final String industry;
  final int salaryMin;
  final int salaryMax;
  final int annualSalary;
  final double feePercentage;
  final double feeAmount;
  final String requirements;
  final String timeline;
  final String status;
  final DateTime createdAt;
  final int submissionsCount;

  const BriefModel({
    required this.briefId, required this.recruiterUid,
    required this.employerUid, required this.roleName,
    required this.industry, required this.salaryMin, required this.salaryMax,
    required this.annualSalary, required this.feePercentage,
    required this.feeAmount, required this.requirements,
    required this.timeline, required this.status, required this.createdAt,
    required this.submissionsCount,
  });

  factory BriefModel.fromJson(Map<String, dynamic> json) => BriefModel(
        briefId: json['briefId'] as String? ?? '',
        recruiterUid: json['recruiterUid'] as String? ?? '',
        employerUid: json['employerUid'] as String? ?? '',
        roleName: json['roleName'] as String? ?? '',
        industry: json['industry'] as String? ?? '',
        salaryMin: json['salaryMin'] as int? ?? 0,
        salaryMax: json['salaryMax'] as int? ?? 0,
        annualSalary: json['annualSalary'] as int? ?? 0,
        feePercentage: (json['feePercentage'] as num?)?.toDouble() ?? 12.0,
        feeAmount: (json['feeAmount'] as num?)?.toDouble() ?? 0.0,
        requirements: json['requirements'] as String? ?? '',
        timeline: json['timeline'] as String? ?? '',
        status: json['status'] as String? ?? 'open',
        createdAt: (json['createdAt'] is Timestamp)
            ? (json['createdAt'] as Timestamp).toDate()
            : DateTime.now(),
        submissionsCount: json['submissionsCount'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'briefId': briefId, 'recruiterUid': recruiterUid,
        'employerUid': employerUid, 'roleName': roleName,
        'industry': industry, 'salaryMin': salaryMin, 'salaryMax': salaryMax,
        'annualSalary': annualSalary, 'feePercentage': feePercentage,
        'feeAmount': feeAmount, 'requirements': requirements,
        'timeline': timeline, 'status': status,
        'createdAt': Timestamp.fromDate(createdAt),
        'submissionsCount': submissionsCount,
      };

  BriefModel copyWith({
    String? briefId, String? recruiterUid, String? employerUid,
    String? roleName, String? industry, int? salaryMin, int? salaryMax,
    int? annualSalary, double? feePercentage, double? feeAmount,
    String? requirements, String? timeline, String? status,
    DateTime? createdAt, int? submissionsCount,
  }) => BriefModel(
        briefId: briefId ?? this.briefId,
        recruiterUid: recruiterUid ?? this.recruiterUid,
        employerUid: employerUid ?? this.employerUid,
        roleName: roleName ?? this.roleName,
        industry: industry ?? this.industry,
        salaryMin: salaryMin ?? this.salaryMin,
        salaryMax: salaryMax ?? this.salaryMax,
        annualSalary: annualSalary ?? this.annualSalary,
        feePercentage: feePercentage ?? this.feePercentage,
        feeAmount: feeAmount ?? this.feeAmount,
        requirements: requirements ?? this.requirements,
        timeline: timeline ?? this.timeline,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        submissionsCount: submissionsCount ?? this.submissionsCount,
      );
}
