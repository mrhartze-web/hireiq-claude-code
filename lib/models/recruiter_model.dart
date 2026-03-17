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

  const RecruiterModel({
    required this.uid, this.agencyName, required this.specialisations,
    required this.placementsCount, required this.averageTimeToFill,
    required this.signalIQEnabled, required this.totalEarnings,
    required this.activeClientsCount, required this.isVerified,
  });

  factory RecruiterModel.fromJson(Map<String, dynamic> json) => RecruiterModel(
        uid: json['uid'] as String? ?? '',
        agencyName: json['agencyName'] as String?,
        specialisations: List<String>.from(json['specialisations'] as List? ?? []),
        placementsCount: json['placementsCount'] as int? ?? 0,
        averageTimeToFill: json['averageTimeToFill'] as int? ?? 0,
        signalIQEnabled: json['signalIQEnabled'] as bool? ?? false,
        totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
        activeClientsCount: json['activeClientsCount'] as int? ?? 0,
        isVerified: json['isVerified'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid, 'agencyName': agencyName, 'specialisations': specialisations,
        'placementsCount': placementsCount, 'averageTimeToFill': averageTimeToFill,
        'signalIQEnabled': signalIQEnabled, 'totalEarnings': totalEarnings,
        'activeClientsCount': activeClientsCount, 'isVerified': isVerified,
      };

  RecruiterModel copyWith({
    String? uid, String? agencyName, List<String>? specialisations,
    int? placementsCount, int? averageTimeToFill, bool? signalIQEnabled,
    double? totalEarnings, int? activeClientsCount, bool? isVerified,
  }) => RecruiterModel(
        uid: uid ?? this.uid, agencyName: agencyName ?? this.agencyName,
        specialisations: specialisations ?? this.specialisations,
        placementsCount: placementsCount ?? this.placementsCount,
        averageTimeToFill: averageTimeToFill ?? this.averageTimeToFill,
        signalIQEnabled: signalIQEnabled ?? this.signalIQEnabled,
        totalEarnings: totalEarnings ?? this.totalEarnings,
        activeClientsCount: activeClientsCount ?? this.activeClientsCount,
        isVerified: isVerified ?? this.isVerified,
      );
}
