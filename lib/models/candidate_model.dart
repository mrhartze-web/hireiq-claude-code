class CandidateModel {
  final String uid;
  final String headline;
  final String location;
  final int yearsExperience;
  final List<String> skills;
  final String? cvUrl;
  final double matchIQScore;
  final bool passportIQVerified;
  final int profileCompletionPercent;
  final String availabilityStatus;
  final int salaryExpectation;
  final List<String> preferredRoles;
  final String bio;

  const CandidateModel({
    required this.uid,
    required this.headline,
    required this.location,
    required this.yearsExperience,
    required this.skills,
    this.cvUrl,
    required this.matchIQScore,
    required this.passportIQVerified,
    required this.profileCompletionPercent,
    required this.availabilityStatus,
    required this.salaryExpectation,
    required this.preferredRoles,
    required this.bio,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        uid: json['uid'] as String? ?? '',
        headline: json['headline'] as String? ?? '',
        location: json['location'] as String? ?? '',
        yearsExperience: json['yearsExperience'] as int? ?? 0,
        skills: List<String>.from(json['skills'] as List? ?? []),
        cvUrl: json['cvUrl'] as String?,
        matchIQScore: (json['matchIQScore'] as num?)?.toDouble() ?? 0.0,
        passportIQVerified: json['passportIQVerified'] as bool? ?? false,
        profileCompletionPercent: json['profileCompletionPercent'] as int? ?? 0,
        availabilityStatus: json['availabilityStatus'] as String? ?? 'available',
        salaryExpectation: json['salaryExpectation'] as int? ?? 0,
        preferredRoles: List<String>.from(json['preferredRoles'] as List? ?? []),
        bio: json['bio'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uid': uid, 'headline': headline, 'location': location,
        'yearsExperience': yearsExperience, 'skills': skills, 'cvUrl': cvUrl,
        'matchIQScore': matchIQScore, 'passportIQVerified': passportIQVerified,
        'profileCompletionPercent': profileCompletionPercent,
        'availabilityStatus': availabilityStatus,
        'salaryExpectation': salaryExpectation,
        'preferredRoles': preferredRoles, 'bio': bio,
      };

  CandidateModel copyWith({
    String? uid, String? headline, String? location, int? yearsExperience,
    List<String>? skills, String? cvUrl, double? matchIQScore,
    bool? passportIQVerified, int? profileCompletionPercent,
    String? availabilityStatus, int? salaryExpectation,
    List<String>? preferredRoles, String? bio,
  }) => CandidateModel(
        uid: uid ?? this.uid, headline: headline ?? this.headline,
        location: location ?? this.location,
        yearsExperience: yearsExperience ?? this.yearsExperience,
        skills: skills ?? this.skills, cvUrl: cvUrl ?? this.cvUrl,
        matchIQScore: matchIQScore ?? this.matchIQScore,
        passportIQVerified: passportIQVerified ?? this.passportIQVerified,
        profileCompletionPercent: profileCompletionPercent ?? this.profileCompletionPercent,
        availabilityStatus: availabilityStatus ?? this.availabilityStatus,
        salaryExpectation: salaryExpectation ?? this.salaryExpectation,
        preferredRoles: preferredRoles ?? this.preferredRoles,
        bio: bio ?? this.bio,
      );
}
