import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String role;
  final String? photoUrl;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String subscriptionTier;
  final String subscriptionStatus;

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.photoUrl,
    required this.isVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriptionTier,
    required this.subscriptionStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      role: json['role'] as String? ?? 'candidate',
      photoUrl: json['photoUrl'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: (json['updatedAt'] is Timestamp)
          ? (json['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      subscriptionTier: json['subscriptionTier'] as String? ?? 'free',
      subscriptionStatus: json['subscriptionStatus'] as String? ?? 'inactive',
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'role': role,
        'photoUrl': photoUrl,
        'isVerified': isVerified,
        'isActive': isActive,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'subscriptionTier': subscriptionTier,
        'subscriptionStatus': subscriptionStatus,
      };

  UserModel copyWith({
    String? uid, String? email, String? displayName, String? role,
    String? photoUrl, bool? isVerified, bool? isActive,
    DateTime? createdAt, DateTime? updatedAt,
    String? subscriptionTier, String? subscriptionStatus,
  }) => UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        role: role ?? this.role,
        photoUrl: photoUrl ?? this.photoUrl,
        isVerified: isVerified ?? this.isVerified,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        subscriptionTier: subscriptionTier ?? this.subscriptionTier,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      );
}
