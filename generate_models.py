import os

models = {
    'user': {
        'fields': {
            'uid': 'String', 'email': 'String', 'displayName': 'String', 'role': 'String',
            'photoUrl': 'String?', 'isVerified': 'bool', 'isActive': 'bool',
            'createdAt': 'DateTime', 'updatedAt': 'DateTime', 'subscriptionTier': 'String', 'subscriptionStatus': 'String'
        }
    },
    'candidate': {
        'fields': {
            'uid': 'String', 'headline': 'String', 'location': 'String', 'yearsExperience': 'int',
            'skills': 'List<String>', 'cvUrl': 'String?', 'matchIQScore': 'double',
            'passportIQVerified': 'bool', 'profileCompletionPercent': 'int', 'availabilityStatus': 'String',
            'salaryExpectation': 'int', 'preferredRoles': 'List<String>', 'bio': 'String'
        }
    },
    'employer': {
        'fields': {
            'uid': 'String', 'companyName': 'String', 'industry': 'String', 'companySize': 'String',
            'location': 'String', 'logoUrl': 'String?', 'description': 'String', 'website': 'String?',
            'bbbeeLevel': 'String?', 'isVerified': 'bool', 'subscriptionTier': 'String', 'activeJobCount': 'int'
        }
    },
    'recruiter': {
        'fields': {
            'uid': 'String', 'agencyName': 'String?', 'specialisations': 'List<String>',
            'placementsCount': 'int', 'averageTimeToFill': 'int', 'signalIQEnabled': 'bool',
            'totalEarnings': 'double', 'activeClientsCount': 'int', 'isVerified': 'bool'
        }
    },
    'job': {
        'fields': {
            'jobId': 'String', 'employerUid': 'String', 'title': 'String', 'company': 'String',
            'location': 'String', 'salaryMin': 'int', 'salaryMax': 'int', 'jobType': 'String',
            'industry': 'String', 'skills': 'List<String>', 'description': 'String',
            'requirements': 'String', 'postedAt': 'DateTime', 'closingDate': 'DateTime?',
            'isActive': 'bool', 'applicationsCount': 'int', 'matchIQEnabled': 'bool', 'wildcardIQEnabled': 'bool'
        }
    },
    'application': {
        'fields': {
            'applicationId': 'String', 'jobId': 'String', 'candidateUid': 'String', 'employerUid': 'String',
            'status': 'String', 'appliedAt': 'DateTime', 'updatedAt': 'DateTime', 'matchIQScore': 'double?',
            'coverNote': 'String?', 'recruiterUid': 'String?'
        }
    },
    'brief': {
        'fields': {
            'briefId': 'String', 'recruiterUid': 'String', 'employerUid': 'String', 'roleName': 'String',
            'industry': 'String', 'salaryMin': 'int', 'salaryMax': 'int', 'annualSalary': 'int',
            'feePercentage': 'double', 'feeAmount': 'double', 'requirements': 'String', 'timeline': 'String',
            'status': 'String', 'createdAt': 'DateTime', 'submissionsCount': 'int'
        }
    },
    'placement': {
        'fields': {
            'placementId': 'String', 'briefId': 'String', 'recruiterUid': 'String', 'employerUid': 'String',
            'candidateUid': 'String', 'roleName': 'String', 'annualSalary': 'int', 'feePercentage': 'double',
            'feeAmount': 'double', 'placedAt': 'DateTime', 'paymentStatus': 'String', 'invoiceUrl': 'String?'
        }
    },
    'notification': {
        'fields': {
            'notificationId': 'String', 'recipientUid': 'String', 'title': 'String', 'body': 'String',
            'type': 'String', 'isRead': 'bool', 'createdAt': 'DateTime', 'actionRoute': 'String?'
        }
    },
    'message': {
        'fields': {
            'messageId': 'String', 'conversationId': 'String', 'senderUid': 'String', 'recipientUid': 'String',
            'body': 'String', 'sentAt': 'DateTime', 'isRead': 'bool', 'attachmentUrl': 'String?'
        }
    }
}

os.makedirs('lib/models', exist_ok=True)

for name, data in models.items():
    class_name = name.capitalize() + 'Model'
    fields = data['fields']
    
    props = []
    constructor_args = []
    copy_with_args = []
    copy_with_assign = []
    from_json_assign = []
    to_json_props = []
    
    for fname, ftype in fields.items():
        is_nullable = ftype.endswith('?')
        base_type = ftype.replace('?', '')
        
        props.append(f"  final {ftype} {fname};")
        
        if is_nullable:
            constructor_args.append(f"    this.{fname},")
        else:
            constructor_args.append(f"    required this.{fname},")
            
        copy_with_args.append(f"    {ftype} {fname},")
        copy_with_assign.append(f"      {fname}: {fname} ?? this.{fname},")
        
        if base_type == 'DateTime':
            if is_nullable:
                 from_json_assign.append(f"      {fname}: json['{fname}'] != null ? (json['{fname}'] is Timestamp ? (json['{fname}'] as Timestamp).toDate() : DateTime.parse(json['{fname}'].toString())) : null,")
                 to_json_props.append(f"      '{fname}': {fname}?.toIso8601String(),")
            else:
                 from_json_assign.append(f"      {fname}: json['{fname}'] is Timestamp ? (json['{fname}'] as Timestamp).toDate() : DateTime.parse(json['{fname}'].toString()),")
                 to_json_props.append(f"      '{fname}': {fname}.toIso8601String(),")
        elif base_type == 'List<String>':
             if is_nullable:
                 from_json_assign.append(f"      {fname}: (json['{fname}'] as List<dynamic>?)?.map((e) => e.toString()).toList(),")
                 to_json_props.append(f"      '{fname}': {fname},")
             else:
                 from_json_assign.append(f"      {fname}: (json['{fname}'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],")
                 to_json_props.append(f"      '{fname}': {fname},")
        elif base_type == 'double':
             if is_nullable:
                 from_json_assign.append(f"      {fname}: json['{fname}'] != null ? (json['{fname}'] as num).toDouble() : null,")
                 to_json_props.append(f"      '{fname}': {fname},")
             else:
                 from_json_assign.append(f"      {fname}: (json['{fname}'] as num?)?.toDouble() ?? 0.0,")
                 to_json_props.append(f"      '{fname}': {fname},")
        elif base_type == 'int':
             if is_nullable:
                 from_json_assign.append(f"      {fname}: json['{fname}'] != null ? (json['{fname}'] as num).toInt() : null,")
                 to_json_props.append(f"      '{fname}': {fname},")
             else:
                 from_json_assign.append(f"      {fname}: (json['{fname}'] as num?)?.toInt() ?? 0,")
                 to_json_props.append(f"      '{fname}': {fname},")
        elif base_type == 'bool':
            if is_nullable:
                from_json_assign.append(f"      {fname}: json['{fname}'] as bool?,")
                to_json_props.append(f"      '{fname}': {fname},")
            else:
                from_json_assign.append(f"      {fname}: json['{fname}'] as bool? ?? false,")
                to_json_props.append(f"      '{fname}': {fname},")
        else:
            if is_nullable:
                from_json_assign.append(f"      {fname}: json['{fname}'] as String?,")
                to_json_props.append(f"      '{fname}': {fname},")
            else:
                from_json_assign.append(f"      {fname}: json['{fname}'] as String? ?? '',")
                to_json_props.append(f"      '{fname}': {fname},")

    code = f"""import 'package:cloud_firestore/cloud_firestore.dart';

class {class_name} {{
{chr(10).join(props)}

  const {class_name}({{
{chr(10).join(constructor_args)}
  }});

  {class_name} copyWith({{
{chr(10).join(copy_with_args)}
  }}) {{
    return {class_name}(
{chr(10).join(copy_with_assign)}
    );
  }}

  factory {class_name}.fromJson(Map<String, dynamic> json) {{
    return {class_name}(
{chr(10).join(from_json_assign)}
    );
  }}

  Map<String, dynamic> toJson() {{
    return {{
{chr(10).join(to_json_props)}
    }};
  }}
}}
"""
    file_path = f"lib/models/{name}_model.dart"
    with open(file_path, 'w') as f:
        f.write(code)

print("Generated all models successfully.")
