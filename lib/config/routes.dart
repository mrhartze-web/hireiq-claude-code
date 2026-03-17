import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Auth
import '../screens/auth/splash_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/forgot_password_screen.dart';

// Candidate
import '../screens/candidate/candidate_onboarding_1_screen.dart';
import '../screens/candidate/candidate_onboarding_2_screen.dart';
import '../screens/candidate/candidate_onboarding_3_screen.dart';
import '../screens/candidate/candidate_onboarding_4_screen.dart';
import '../screens/candidate/candidate_onboarding_5_screen.dart';
import '../screens/candidate/job_feed_screen.dart';
import '../screens/candidate/job_detail_screen.dart';
import '../screens/candidate/smart_apply_modal.dart';
import '../screens/candidate/application_tracker_screen.dart';
import '../screens/candidate/application_detail_screen.dart';
import '../screens/candidate/candidate_profile_screen.dart';
import '../screens/candidate/edit_profile_screen.dart';
import '../screens/candidate/skill_assessment_screen.dart';
import '../screens/candidate/assessment_inprogress_screen.dart';
import '../screens/candidate/assessment_result_screen.dart';
import '../screens/candidate/video_pitch_screen.dart';
import '../screens/candidate/career_uplift_path_screen.dart';

// Employer
import '../screens/employer/employer_onboarding_1_screen.dart';
import '../screens/employer/employer_onboarding_2_screen.dart';
import '../screens/employer/employer_onboarding_3_screen.dart';
import '../screens/employer/employer_dashboard_screen.dart';
import '../screens/employer/my_jobs_screen.dart';
import '../screens/employer/post_job_screen.dart';
import '../screens/employer/shortlist_view_screen.dart';
import '../screens/employer/shortlist_report_screen.dart';
import '../screens/employer/candidate_detail_screen.dart';
import '../screens/employer/confirm_hire_screen.dart';
import '../screens/employer/hiring_analytics_screen.dart';
import '../screens/employer/employer_settings_screen.dart';

// Recruiter
import '../screens/recruiter/recruiter_dashboard_screen.dart';
import '../screens/recruiter/crm_pipeline_screen.dart';
import '../screens/recruiter/cv_vault_screen.dart';
import '../screens/recruiter/brief_upload_screen.dart';
import '../screens/recruiter/brief_shortlist_report_screen.dart';
import '../screens/recruiter/recruiter_settings_screen.dart';

// Gig
import '../screens/gig/gig_feed_screen.dart';
import '../screens/gig/gig_detail_screen.dart';
import '../screens/gig/submit_proposal_screen.dart';
import '../screens/gig/active_contract_screen.dart';
import '../screens/gig/gig_management_screen.dart';
import '../screens/gig/proposals_view_screen.dart';
import '../screens/gig/freelancer_profile_screen.dart';

// Shared
import '../screens/shared/notifications_screen.dart';
import '../screens/shared/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // Auth
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/role-selection',
          builder: (context, state) => const RoleSelectionScreen()),
      GoRoute(
          path: '/signup', builder: (context, state) => const SignupScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen()),

      // Candidate Onboarding
      GoRoute(
          path: '/candidate-onboarding-1',
          builder: (context, state) => const CandidateOnboarding1Screen()),
      GoRoute(
          path: '/candidate-onboarding-2',
          builder: (context, state) => const CandidateOnboarding2Screen()),
      GoRoute(
          path: '/candidate-onboarding-3',
          builder: (context, state) => const CandidateOnboarding3Screen()),
      GoRoute(
          path: '/candidate-onboarding-4',
          builder: (context, state) => const CandidateOnboarding4Screen()),
      GoRoute(
          path: '/candidate-onboarding-5',
          builder: (context, state) => const CandidateOnboarding5Screen()),

      // Candidate Core
      GoRoute(
          path: '/job-feed',
          builder: (context, state) => const JobFeedScreen()),
      GoRoute(
          path: '/job-detail',
          builder: (context, state) => const JobDetailScreen()),
      GoRoute(
          path: '/smart-apply',
          builder: (context, state) => const SmartApplyModal()),
      GoRoute(
          path: '/application-tracker',
          builder: (context, state) => const ApplicationTrackerScreen()),
      GoRoute(
          path: '/application-detail',
          builder: (context, state) => const ApplicationDetailScreen()),
      GoRoute(
          path: '/candidate-profile',
          builder: (context, state) => const CandidateProfileScreen()),
      GoRoute(
          path: '/edit-profile',
          builder: (context, state) => const EditProfileScreen()),
      GoRoute(
          path: '/skill-assessment',
          builder: (context, state) => const SkillAssessmentScreen()),
      GoRoute(
          path: '/assessment-inprogress',
          builder: (context, state) => const AssessmentInprogressScreen()),
      GoRoute(
          path: '/assessment-result',
          builder: (context, state) => const AssessmentResultScreen()),
      GoRoute(
          path: '/video-pitch',
          builder: (context, state) => const VideoPitchScreen()),
      GoRoute(
          path: '/career-uplift',
          builder: (context, state) => const CareerUpliftPathScreen()),

      // Employer Onboarding
      GoRoute(
          path: '/employer-onboarding-1',
          builder: (context, state) => const EmployerOnboarding1Screen()),
      GoRoute(
          path: '/employer-onboarding-2',
          builder: (context, state) => const EmployerOnboarding2Screen()),
      GoRoute(
          path: '/employer-onboarding-3',
          builder: (context, state) => const EmployerOnboarding3Screen()),

      // Employer Core
      GoRoute(
          path: '/employer-dashboard',
          builder: (context, state) => const EmployerDashboardScreen()),
      GoRoute(
          path: '/my-jobs', builder: (context, state) => const MyJobsScreen()),
      GoRoute(
          path: '/post-job',
          builder: (context, state) => const PostJobScreen()),
      GoRoute(
          path: '/shortlist',
          builder: (context, state) => const ShortlistViewScreen()),
      GoRoute(
          path: '/shortlist-report',
          builder: (context, state) => const ShortlistReportScreen()),
      GoRoute(
          path: '/candidate-detail',
          builder: (context, state) => const CandidateDetailScreen()),
      GoRoute(
          path: '/confirm-hire',
          builder: (context, state) => const ConfirmHireScreen()),
      GoRoute(
          path: '/hiring-analytics',
          builder: (context, state) => const HiringAnalyticsScreen()),
      GoRoute(
          path: '/employer-settings',
          builder: (context, state) => const EmployerSettingsScreen()),

      // Recruiter
      GoRoute(
          path: '/recruiter-dashboard',
          builder: (context, state) => const RecruiterDashboardScreen()),
      GoRoute(
          path: '/crm-pipeline',
          builder: (context, state) => const CrmPipelineScreen()),
      GoRoute(
          path: '/cv-vault',
          builder: (context, state) => const CvVaultScreen()),
      GoRoute(
          path: '/brief-upload',
          builder: (context, state) => const BriefUploadScreen()),
      GoRoute(
          path: '/brief-shortlist',
          builder: (context, state) => const BriefShortlistReportScreen()),
      GoRoute(
          path: '/recruiter-settings',
          builder: (context, state) => const RecruiterSettingsScreen()),

      // Gig
      GoRoute(
          path: '/gig-feed',
          builder: (context, state) => const GigFeedScreen()),
      GoRoute(
          path: '/gig-detail',
          builder: (context, state) => const GigDetailScreen()),
      GoRoute(
          path: '/submit-proposal',
          builder: (context, state) => const SubmitProposalScreen()),
      GoRoute(
          path: '/active-contract',
          builder: (context, state) => const ActiveContractScreen()),
      GoRoute(
          path: '/gig-management',
          builder: (context, state) => const GigManagementScreen()),
      GoRoute(
          path: '/proposals-view',
          builder: (context, state) => const ProposalsViewScreen()),
      GoRoute(
          path: '/freelancer-profile',
          builder: (context, state) => const FreelancerProfileScreen()),

      // Shared
      GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen()),
      GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen()),
    ],
  );
});
