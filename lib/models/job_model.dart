import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String jobId;
  final String employerUid;
  final String title;
  final String company;
  final String location;
  final int salaryMin;
  final int salaryMax;
  final String jobType;
  final String industry;
  final List<String> skills;
  final String description;
  final String requirements;
  final DateTime postedAt;
  final DateTime? closingDate;
  final bool isActive;
  final int applicationsCount;
  final bool matchIQEnabled;
  final bool wildcardIQEnabled;

  const JobModel({
    required this.jobId, required this.employerUid, required this.title,
    required this.company, required this.location, required this.salaryMin,
    required this.salaryMax, required this.jobType, required this.industry,
    required this.skills, required this.description, required this.requirements,
    required this.postedAt, this.closingDate, required this.isActive,
    required this.applicationsCount, required this.matchIQEnabled,
    required this.wildcardIQEnabled,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        jobId: json['jobId'] as String? ?? '',
        employerUid: json['employerUid'] as String? ?? '',
        title: json['title'] as String? ?? '',
        company: json['company'] as String? ?? '',
        location: json['location'] as String? ?? '',
        salaryMin: json['salaryMin'] as int? ?? 0,
        salaryMax: json['salaryMax'] as int? ?? 0,
        jobType: json['jobType'] as String? ?? 'permanent',
        industry: json['industry'] as String? ?? '',
        skills: List<String>.from(json['skills'] as List? ?? []),
        description: json['description'] as String? ?? '',
        requirements: json['requirements'] as String? ?? '',
        postedAt: (json['postedAt'] is Timestamp)
            ? (json['postedAt'] as Timestamp).toDate()
            : DateTime.now(),
        closingDate: json['closingDate'] != null
            ? (json['closingDate'] is Timestamp)
                ? (json['closingDate'] as Timestamp).toDate()
                : null
            : null,
        isActive: json['isActive'] as bool? ?? true,
        applicationsCount: json['applicationsCount'] as int? ?? 0,
        matchIQEnabled: json['matchIQEnabled'] as bool? ?? true,
        wildcardIQEnabled: json['wildcardIQEnabled'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'jobId': jobId, 'employerUid': employerUid, 'title': title,
        'company': company, 'location': location, 'salaryMin': salaryMin,
        'salaryMax': salaryMax, 'jobType': jobType, 'industry': industry,
        'skills': skills, 'description': description,
        'requirements': requirements,
        'postedAt': Timestamp.fromDate(postedAt),
        'closingDate': closingDate != null ? Timestamp.fromDate(closingDate!) : null,
        'isActive': isActive, 'applicationsCount': applicationsCount,
        'matchIQEnabled': matchIQEnabled, 'wildcardIQEnabled': wildcardIQEnabled,
      };

  JobModel copyWith({
    String? jobId, String? employerUid, String? title, String? company,
    String? location, int? salaryMin, int? salaryMax, String? jobType,
    String? industry, List<String>? skills, String? description,
    String? requirements, DateTime? postedAt, DateTime? closingDate,
    bool? isActive, int? applicationsCount, bool? matchIQEnabled,
    bool? wildcardIQEnabled,
  }) => JobModel(
        jobId: jobId ?? this.jobId,
        employerUid: employerUid ?? this.employerUid,
        title: title ?? this.title, company: company ?? this.company,
        location: location ?? this.location,
        salaryMin: salaryMin ?? this.salaryMin,
        salaryMax: salaryMax ?? this.salaryMax,
        jobType: jobType ?? this.jobType, industry: industry ?? this.industry,
        skills: skills ?? this.skills, description: description ?? this.description,
        requirements: requirements ?? this.requirements,
        postedAt: postedAt ?? this.postedAt,
        closingDate: closingDate ?? this.closingDate,
        isActive: isActive ?? this.isActive,
        applicationsCount: applicationsCount ?? this.applicationsCount,
        matchIQEnabled: matchIQEnabled ?? this.matchIQEnabled,
        wildcardIQEnabled: wildcardIQEnabled ?? this.wildcardIQEnabled,
      );
}
