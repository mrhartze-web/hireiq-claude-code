import 'package:cloud_firestore/cloud_firestore.dart';

class PlacementModel {
  final String placementId;
  final String briefId;
  final String recruiterUid;
  final String employerUid;
  final String candidateUid;
  final String roleName;
  final int annualSalary;
  final double feePercentage;
  final double feeAmount;
  final DateTime placedAt;
  final String paymentStatus;
  final String? invoiceUrl;

  const PlacementModel({
    required this.placementId, required this.briefId,
    required this.recruiterUid, required this.employerUid,
    required this.candidateUid, required this.roleName,
    required this.annualSalary, required this.feePercentage,
    required this.feeAmount, required this.placedAt,
    required this.paymentStatus, this.invoiceUrl,
  });

  factory PlacementModel.fromJson(Map<String, dynamic> json) => PlacementModel(
        placementId: json['placementId'] as String? ?? '',
        briefId: json['briefId'] as String? ?? '',
        recruiterUid: json['recruiterUid'] as String? ?? '',
        employerUid: json['employerUid'] as String? ?? '',
        candidateUid: json['candidateUid'] as String? ?? '',
        roleName: json['roleName'] as String? ?? '',
        annualSalary: json['annualSalary'] as int? ?? 0,
        feePercentage: (json['feePercentage'] as num?)?.toDouble() ?? 12.0,
        feeAmount: (json['feeAmount'] as num?)?.toDouble() ?? 0.0,
        placedAt: (json['placedAt'] is Timestamp)
            ? (json['placedAt'] as Timestamp).toDate()
            : DateTime.now(),
        paymentStatus: json['paymentStatus'] as String? ?? 'pending',
        invoiceUrl: json['invoiceUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'placementId': placementId, 'briefId': briefId,
        'recruiterUid': recruiterUid, 'employerUid': employerUid,
        'candidateUid': candidateUid, 'roleName': roleName,
        'annualSalary': annualSalary, 'feePercentage': feePercentage,
        'feeAmount': feeAmount, 'placedAt': Timestamp.fromDate(placedAt),
        'paymentStatus': paymentStatus, 'invoiceUrl': invoiceUrl,
      };

  PlacementModel copyWith({
    String? placementId, String? briefId, String? recruiterUid,
    String? employerUid, String? candidateUid, String? roleName,
    int? annualSalary, double? feePercentage, double? feeAmount,
    DateTime? placedAt, String? paymentStatus, String? invoiceUrl,
  }) => PlacementModel(
        placementId: placementId ?? this.placementId,
        briefId: briefId ?? this.briefId,
        recruiterUid: recruiterUid ?? this.recruiterUid,
        employerUid: employerUid ?? this.employerUid,
        candidateUid: candidateUid ?? this.candidateUid,
        roleName: roleName ?? this.roleName,
        annualSalary: annualSalary ?? this.annualSalary,
        feePercentage: feePercentage ?? this.feePercentage,
        feeAmount: feeAmount ?? this.feeAmount,
        placedAt: placedAt ?? this.placedAt,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        invoiceUrl: invoiceUrl ?? this.invoiceUrl,
      );
}
