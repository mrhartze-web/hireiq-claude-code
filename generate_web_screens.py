import os

candidate_screens = [
    'candidate_dashboard_home_web', 'candidate_job_search_web', 'candidate_job_detail_web', 'candidate_profile_web', 'candidate_applications_web',
    'candidate_messages_web', 'candidate_notifications_web', 'candidate_passport_iq_web', 'candidate_forge_iq_web', 'candidate_uplift_iq_web',
    'candidate_matchiq_explanation_web', 'candidate_gig_dashboard_web', 'candidate_career_goals_web', 'candidate_references_web', 'candidate_salary_guide_web',
    'candidate_interview_prep_web', 'candidate_subscription_upgrade_web', 'candidate_billing_settings_web', 'candidate_privacy_settings_web',
    'candidate_security_settings_web', 'candidate_complete_profile_web', 'candidate_public_profile_web', 'candidate_referral_web', 'candidate_saved_jobs_web',
    'candidate_smart_apply_web', 'candidate_onboarding_welcome_web'
]

employer_screens = [
    'employer_dashboard_web', 'employer_candidate_search_web', 'employer_candidate_pipeline_web', 'employer_shortlist_web',
    'employer_offer_management_web', 'employer_interview_scheduler_web', 'employer_interview_detail_web', 'employer_post_job_web',
    'employer_my_jobs_web', 'employer_analytics_web', 'employer_diversity_report_web', 'employer_wildcard_iq_web', 'employer_signal_iq_web',
    'employer_billing_web', 'employer_company_profile_web', 'employer_onboarding_web'
]

recruiter_screens = [
    'recruiter_dashboard_web', 'recruiter_pipeline_web', 'recruiter_briefs_web', 'recruiter_brief_builder_web', 'recruiter_candidate_search_web',
    'recruiter_candidate_submission_web', 'recruiter_placement_tracker_web', 'recruiter_earnings_dashboard_web', 'recruiter_client_management_web',
    'recruiter_performance_dashboard_web', 'recruiter_cv_vault_web', 'recruiter_settings_web'
]

admin_screens = [
    'admin_dashboard_web', 'admin_users_web', 'admin_employer_management_web', 'admin_recruiter_management_web',
    'admin_content_moderation_web', 'admin_platform_analytics_web', 'admin_system_settings_web'
]

public_screens = [
    'landing_page', 'pricing_page', 'about_page', 'contact_page', 'blog_page', 'system_status_page', 'error_404_page',
    'thundafund_landing', 'thundafund_rewards', 'thundafund_story', 'thundafund_social_proof', 'thundafund_faq', 'thundafund_updates'
]

def to_class_name(snake_str):
    return ''.join(x.title() for x in snake_str.split('_'))

def generate_screen(folder, file_base):
    class_name = to_class_name(file_base)
    path = f'lib/features/{folder}/{file_base}.dart'
    
    title = class_name.replace('Web', '').replace('Page', '').replace('Candidate', '').replace('Employer', '').replace('Recruiter', '').replace('Admin', '')
    if not title: title = class_name

    body_content = f"""
            Text(
              'Welcome to {title}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: const Text('Web View Content coming soon...'),
            ),
"""

    if file_base == 'employer_dashboard_web':
        body_content = """
            const Text(
              'Employer Dashboard',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(color: HireIQTheme.primaryTeal, width: 6), top: BorderSide(color: HireIQTheme.borderLight), right: BorderSide(color: HireIQTheme.borderLight), bottom: BorderSide(color: HireIQTheme.borderLight)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                         Text('Direct hire or recruiter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
                         SizedBox(height: 8),
                         Text('Use HireIQ directly for volume and standard roles. Engage a HireIQ recruiter for senior, specialist, or hard-to-fill positions. Both options work together on your account.', style: TextStyle(color: HireIQTheme.textMuted)),
                       ]
                     )
                   ),
                   IconButton(icon: const Icon(Icons.close), onPressed: (){})
                ]
              )
            ),
"""

    if file_base == 'recruiter_earnings_dashboard_web':
        body_content = """
            const Text(
              'Earnings Dashboard',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
             Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Annual Salary', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Fee Percentage', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Fee Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Senior Developer')),
                    DataCell(Text('R300,000')),
                    DataCell(Text('12%')),
                    DataCell(Text('R36,000')),
                  ])
                ]
              )
            ),
"""

    code = f"""import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class {class_name} extends StatelessWidget {{
  const {class_name}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [{body_content}
          ],
        ),
      ),
    );
  }}
}}
"""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(code)

all_maps = {
    'candidate': candidate_screens,
    'employer': employer_screens,
    'recruiter': recruiter_screens,
    'admin': admin_screens,
    'public': public_screens
}

exports = []

for folder, files in all_maps.items():
    for f in files:
        generate_screen(folder, f)
        exports.append(f"export '{folder}/{f}.dart';")

with open('lib/features/web_screens.dart', 'w', encoding='utf-8') as f:
    f.write('\\n'.join(exports) + '\\n')
