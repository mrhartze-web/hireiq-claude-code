class RecruiterModel {
  final String uid;
  final String? agencyName;
  final List<String> specialisations;
  final int placementsCount;
  final int averageTimeToFill;
  final bool signalIQEnabled;
  final double totalEarnings;
  final int activeClientsCount;
  final bool isVerified;

  // ── Security / abuse-prevention fields ──────────────────────────────────────
  final bool firstPlacementFreeUsed;
  final String? phoneNumberHash;
  final DateTime? phoneVerifiedAt;
  final bool emailVerified;
  final String? signupIP;
  final String recruiterRiskLevel;

  const RecruiterModel({
    required this.uid,
    this.agencyName,
    required this.specialisations,
    required this.placementsCount,
    required this.averageTimeToFill,
    required this.signalIQEnabled,
    required this.totalEarnings,
    required this.activeClientsCount,
    required this.isVerified,
    this.firstPlacementFreeUsed = false,
    this.phoneNumberHash,
    this.phoneVerifiedAt,
    this.emailVerified = false,
    this.signupIP,
    this.recruiterRiskLevel = 'LOW',
  });

  factory RecruiterModel.fromJson(Map<String, dynamic> json) => RecruiterModel(
        uid: json['uid'] as String? ?? '',
        agencyName: json['agencyName'] as String?,
        specialisations:
            List<String>.from(json['specialisations'] as List? ?? []),
        placementsCount: json['placementsCount'] as int? ?? 0,
        averageTimeToFill: json['averageTimeToFill'] as int? ?? 0,
        signalIQEnabled: json['signalIQEnabled'] as bool? ?? false,
        totalEarnings:
            (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
        activeClientsCount: json['activeClientsCount'] as int? ?? 0,
        isVerified: json['isVerified'] as bool? ?? false,
        firstPlacementFreeUsed:
            json['firstPlacementFreeUsed'] as bool? ?? false,
        phoneNumberHash: json['phoneNumberHash'] as String?,
        phoneVerifiedAt: json['phoneVerifiedAt'] != null
            ? (json['phoneVerifiedAt'] as dynamic).toDate() as DateTime?
            : null,
        emailVerified: json['emailVerified'] as bool? ?? false,
        signupIP: json['signupIP'] as String?,
        recruiterRiskLevel:
            json['recruiterRiskLevel'] as String? ?? 'LOW',
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'agencyName': agencyName,
        'specialisations': specialisations,
        'placementsCount': placementsCount,
        'averageTimeToFill': averageTimeToFill,
        'signalIQEnabled': signalIQEnabled,
        'totalEarnings': totalEarnings,
        'activeClientsCount': activeClientsCount,
        'isVerified': isVerified,
        'firstPlacementFreeUsed': firstPlacementFreeUsed,
        'phoneNumberHash': phoneNumberHash,
        'phoneVerifiedAt': phoneVerifiedAt,
        'emailVerified': emailVerified,
        'signupIP': signupIP,
        'recruiterRiskLevel': recruiterRiskLevel,
      };

  RecruiterModel copyWith({
    String? uid,
    String? agencyName,
    List<String>? specialisations,
    int? placementsCount,
    int? averageTimeToFill,
    bool? signalIQEnabled,
    double? totalEarnings,
    int? activeClientsCount,
    bool? isVerified,
    bool? firstPlacementFreeUsed,
    String? phoneNumberHash,
    DateTime? phoneVerifiedAt,
    bool? emailVerified,
    String? signupIP,
    String? recruiterRiskLevel,
  }) =>
      RecruiterModel(
        uid: uid ?? this.uid,
        agencyName: agencyName ?? this.agencyName,
        specialisations: specialisations ?? this.specialisations,
        placementsCount: placementsCount ?? this.placementsCount,
        averageTimeToFill: averageTimeToFill ?? this.averageTimeToFill,
        signalIQEnabled: signalIQEnabled ?? this.signalIQEnabled,
        totalEarnings: totalEarnings ?? this.totalEarnings,
        activeClientsCount: activeClientsCount ?? this.activeClientsCount,
        isVerified: isVerified ?? this.isVerified,
        firstPlacementFreeUsed:
            firstPlacementFreeUsed ?? this.firstPlacementFreeUsed,
        phoneNumberHash: phoneNumberHash ?? this.phoneNumberHash,
        phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
        emailVerified: emailVerified ?? this.emailVerified,
        signupIP: signupIP ?? this.signupIP,
        recruiterRiskLevel: recruiterRiskLevel ?? this.recruiterRiskLevel,
      );
}
