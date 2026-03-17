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

def to_route_path(snake_str, prefix):
    base = snake_str.replace('_web', '').replace('_page', '').replace('candidate_', '').replace('employer_', '').replace('recruiter_', '').replace('admin_', '')
    return base.replace('_', '-')

routes_str = '\\n      // --- Web Routes ---\\n'

for s in candidate_screens:
    routes_str += f"      GoRoute(path: '/web/candidate/{to_route_path(s, 'candidate')}', builder: (context, state) => const {to_class_name(s)}()),\\n"

for s in employer_screens:
    routes_str += f"      GoRoute(path: '/web/employer/{to_route_path(s, 'employer')}', builder: (context, state) => const {to_class_name(s)}()),\\n"

for s in recruiter_screens:
    routes_str += f"      GoRoute(path: '/web/recruiter/{to_route_path(s, 'recruiter')}', builder: (context, state) => const {to_class_name(s)}()),\\n"

for s in admin_screens:
    routes_str += f"      GoRoute(path: '/web/admin/{to_route_path(s, 'admin')}', builder: (context, state) => const {to_class_name(s)}()),\\n"

for s in public_screens:
    path = '/' if s == 'landing_page' else f"/{to_route_path(s, '')}"
    routes_str += f"      GoRoute(path: '{path}', builder: (context, state) => const {to_class_name(s)}()),\\n"

with open('lib/router/app_router.dart', 'r', encoding='utf-8') as f:
    text = f.read()

text = text.replace("import '../features/mobile_screens.dart';", "import '../features/mobile_screens.dart';\\nimport '../features/web_screens.dart';")

text = text.replace('      // Shell 4: Admin', routes_str + '\\n      // Shell 4: Admin')

with open('lib/router/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(text)
