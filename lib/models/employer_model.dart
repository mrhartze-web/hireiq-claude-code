class EmployerModel {
  final String uid;
  final String companyName;
  final String industry;
  final String companySize;
  final String location;
  final String? logoUrl;
  final String description;
  final String? website;
  final String? bbbeeLevel;
  final bool isVerified;
  final String subscriptionTier;
  final int activeJobCount;

  const EmployerModel({
    required this.uid, required this.companyName, required this.industry,
    required this.companySize, required this.location, this.logoUrl,
    required this.description, this.website, this.bbbeeLevel,
    required this.isVerified, required this.subscriptionTier,
    required this.activeJobCount,
  });

  factory EmployerModel.fromJson(Map<String, dynamic> json) => EmployerModel(
        uid: json['uid'] as String? ?? '',
        companyName: json['companyName'] as String? ?? '',
        industry: json['industry'] as String? ?? '',
        companySize: json['companySize'] as String? ?? '',
        location: json['location'] as String? ?? '',
        logoUrl: json['logoUrl'] as String?,
        description: json['description'] as String? ?? '',
        website: json['website'] as String?,
        bbbeeLevel: json['bbbeeLevel'] as String?,
        isVerified: json['isVerified'] as bool? ?? false,
        subscriptionTier: json['subscriptionTier'] as String? ?? 'starter',
        activeJobCount: json['activeJobCount'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid, 'companyName': companyName, 'industry': industry,
        'companySize': companySize, 'location': location, 'logoUrl': logoUrl,
        'description': description, 'website': website, 'bbbeeLevel': bbbeeLevel,
        'isVerified': isVerified, 'subscriptionTier': subscriptionTier,
        'activeJobCount': activeJobCount,
      };

  EmployerModel copyWith({
    String? uid, String? companyName, String? industry, String? companySize,
    String? location, String? logoUrl, String? description, String? website,
    String? bbbeeLevel, bool? isVerified, String? subscriptionTier,
    int? activeJobCount,
  }) => EmployerModel(
        uid: uid ?? this.uid, companyName: companyName ?? this.companyName,
        industry: industry ?? this.industry,
        companySize: companySize ?? this.companySize,
        location: location ?? this.location, logoUrl: logoUrl ?? this.logoUrl,
        description: description ?? this.description,
        website: website ?? this.website, bbbeeLevel: bbbeeLevel ?? this.bbbeeLevel,
        isVerified: isVerified ?? this.isVerified,
        subscriptionTier: subscriptionTier ?? this.subscriptionTier,
        activeJobCount: activeJobCount ?? this.activeJobCount,
      );
}
