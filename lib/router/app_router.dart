import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../features/mobile_screens.dart';
import '../features/web_screens.dart';
import '../shared/navigation/role_navigation_bar.dart';

// Import Public & Common Screens
import '../features/public/splash_screen.dart';
import '../features/public/login_screen.dart';
import '../features/public/signup_screen.dart';
import '../features/public/email_verification_screen.dart';
import '../features/public/social_auth_loading.dart';
import '../features/public/forgot_password_screen.dart';
import '../features/public/onboarding_screens.dart';
import '../features/public/role_selection_screen.dart';
import '../features/public/pricing_screen.dart';
import '../features/public/password_reset_success_screen.dart';
import '../features/public/settings_screen.dart';
import '../features/public/legal_screens.dart';
import '../features/public/notifications_screen.dart';
import '../features/public/messages_screen.dart';
import '../features/public/message_thread_screen.dart';
import '../features/public/phone_verification_screen.dart';

// Import Candidate Screens
import '../features/candidate/candidate_job_feed.dart';
import '../features/candidate/candidate_profile.dart';
import '../features/candidate/candidate_application_tracker.dart';
import '../features/candidate/application_timeline_screen.dart';
import '../features/candidate/candidate_job_detail.dart';
import '../features/candidate/edit_profile_screen.dart';
import '../features/candidate/skill_assessment.dart';
import '../features/candidate/assessment_results.dart';
import '../features/candidate/video_pitch.dart';
import '../features/candidate/career_roadmap.dart';
import '../features/candidate/cv_preview_screen.dart';
import '../features/candidate/wildcard_score_detail.dart';
import '../features/candidate/candidate_gig_feed.dart';
import '../features/candidate/candidate_gig_detail.dart';
import '../features/candidate/passport_iq_screens.dart';
import '../features/candidate/uplift_iq_screen.dart';
import '../features/candidate/candidate_billing_settings.dart';
import '../features/candidate/candidate_complete_profile.dart';
import '../features/candidate/candidate_forge_iq.dart';
import '../features/candidate/candidate_interview_prep.dart';
import '../features/candidate/candidate_matchiq_explanation.dart';
import '../features/candidate/candidate_messages_inbox.dart';
import '../features/candidate/candidate_notifications.dart';
import '../features/candidate/candidate_onboarding_welcome.dart';
import '../features/candidate/candidate_privacy_settings.dart';
import '../features/candidate/candidate_public_profile.dart';
import '../features/candidate/candidate_referral.dart';
import '../features/candidate/candidate_security_settings.dart';

// Import Employer Screens
import '../features/employer/employer_dashboard.dart';
import '../features/employer/enterprise_dashboard.dart';
import '../features/employer/employer_jobs.dart';
import '../features/employer/employer_post_job.dart';
import '../features/employer/employer_analytics.dart';
import '../features/employer/employer_team_management.dart';
import '../features/employer/employer_payments.dart';
import '../features/employer/leave_review.dart';
import '../features/employer/employer_dispute.dart';
import '../features/employer/employer_billing.dart';
import '../features/employer/employer_candidates.dart';
import '../features/employer/employer_candidate_pipeline.dart';
import '../features/employer/employer_candidate_search.dart';
import '../features/employer/employer_company_profile.dart';
import '../features/employer/employer_diversity_report.dart';
import '../features/employer/employer_interview_detail.dart';
import '../features/employer/employer_interview_scheduler.dart';
import '../features/employer/employer_login.dart';
import '../features/employer/employer_offer_management.dart';
import '../features/employer/employer_onboarding_steps.dart';
import '../features/employer/employer_post_gig.dart';
import '../features/employer/employer_shortlist.dart';
import '../features/employer/employer_signal_iq.dart';
import '../features/employer/employer_wildcard_iq.dart';

// Import Recruiter Screens
import '../features/recruiter/recruiter_dashboard.dart';
import '../features/recruiter/recruiter_pipeline.dart';
import '../features/recruiter/recruiter_briefs.dart';
import '../features/recruiter/recruiter_cv_vault.dart';
import '../features/recruiter/recruiter_settings.dart';
import '../features/recruiter/signal_iq_report.dart';
import '../features/recruiter/recruiter_shortlist.dart';
import '../features/recruiter/enterprise_diversity_report.dart';
import '../features/recruiter/recruiter_brief_builder.dart';
import '../features/recruiter/recruiter_candidate_search.dart';
import '../features/recruiter/recruiter_candidate_submission.dart';
import '../features/recruiter/recruiter_client_management.dart';
import '../features/recruiter/recruiter_earnings_dashboard.dart';
import '../features/recruiter/recruiter_messages.dart';
import '../features/recruiter/recruiter_performance_dashboard.dart';
import '../features/recruiter/recruiter_placement_tracker.dart';

// Import Admin Screens
import '../features/admin/admin_dashboard.dart';
import '../features/admin/admin_users.dart';
import '../features/admin/admin_revenue.dart';
import '../features/admin/admin_system_health.dart';
import '../features/admin/admin_content_moderation.dart';
import '../features/admin/admin_employer_management.dart';
import '../features/admin/admin_platform_analytics.dart';
import '../features/admin/admin_recruiter_management.dart';
import '../features/admin/admin_system_settings.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: MobileRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final user = ref.read(authStateProvider).value;
      final role = ref.read(userRoleProvider).value;

      final isAuth = user != null;
      final path = state.uri.path;

      final publicRoutes = [
        MobileRoutes.splash,
        MobileRoutes.login,
        MobileRoutes.signup,
        MobileRoutes.forgotPassword,
        MobileRoutes.roleSelection,
        '/onboarding',
        '/landing',
        '/pricing',
        '/about',
        '/contact',
        '/blog',
      ];

      final isPublicRoute =
          publicRoutes.contains(path) || path.startsWith('/thundafund');

      if (!isAuth && !isPublicRoute) {
        return MobileRoutes.login;
      }

      if (isAuth &&
          (path == MobileRoutes.login || path == MobileRoutes.signup)) {
        // If role is still loading, don't redirect — let explicit navigation handle it.
        // Returning null here prevents a redirect to a non-existent path.
        if (role == null) return null;
        if (role == 'employer') return MobileRoutes.employerDashboard;
        if (role == 'recruiter') return MobileRoutes.recruiterDashboard;
        if (role == 'admin') return MobileRoutes.adminDashboard;
        return MobileRoutes.candidateDashboard;
      }

      if (isAuth && role != null) {
        if (role == 'candidate' &&
            (path.startsWith('/employer') ||
                path.startsWith('/recruiter') ||
                path.startsWith('/admin'))) {
          return '/candidate-dashboard';
        }
        if (role == 'employer' &&
            (path.startsWith('/candidate') ||
                path.startsWith('/recruiter') ||
                path.startsWith('/admin'))) {
          return '/employer-dashboard';
        }
        if (role == 'recruiter' &&
            (path.startsWith('/candidate') ||
                path.startsWith('/employer') ||
                path.startsWith('/admin'))) {
          return '/recruiter-dashboard';
        }
        if (role == 'admin' &&
            (path.startsWith('/candidate') ||
                path.startsWith('/employer') ||
                path.startsWith('/recruiter'))) {
          return '/admin-dashboard';
        }
      }
      return null;
    },
    routes: [
      // Top-level Public Routes
      GoRoute(
          path: MobileRoutes.splash,
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen()),
      GoRoute(
          path: MobileRoutes.login,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: MobileRoutes.signup,
          builder: (context, state) => const SignupScreen()),
      GoRoute(
          path: MobileRoutes.emailVerification,
          builder: (context, state) => const EmailVerificationScreen()),
      GoRoute(
          path: MobileRoutes.socialAuthLoading,
          builder: (context, state) => const SocialAuthLoadingScreen()),
      GoRoute(
          path: MobileRoutes.forgotPassword,
          builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(
          path: MobileRoutes.passwordResetSuccess,
          builder: (context, state) => const PasswordResetSuccessScreen()),
      GoRoute(
          path: MobileRoutes.phoneVerification,
          builder: (context, state) => const PhoneVerificationScreen()),
      GoRoute(
          path: MobileRoutes.roleSelection,
          builder: (context, state) => const RoleSelectionScreen()),
      GoRoute(
          path: MobileRoutes.pricing,
          builder: (context, state) => const PricingScreen()),
      GoRoute(
          path: MobileRoutes.terms,
          builder: (context, state) => const TermsScreen()),
      GoRoute(
          path: MobileRoutes.privacy,
          builder: (context, state) => const PrivacyScreen()),
      GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen()),
      GoRoute(
          path: MobileRoutes.messages,
          builder: (context, state) => const MessagesScreen()),
      GoRoute(
        path: MobileRoutes.messageThread,
        builder: (context, state) =>
            MessageThreadScreen(chatId: state.pathParameters['id'] ?? '1'),
      ),

      // Shell 1: Candidate
      ShellRoute(
        builder: (context, state, child) => MainShell(
            title: 'Candidate', role: UserRole.candidate, child: child),
        routes: [
          GoRoute(
              path: MobileRoutes.candidateDashboard,
              builder: (context, state) => const CandidateJobFeed()),
          GoRoute(
              path: MobileRoutes.candidateProfile,
              builder: (context, state) => const CandidateProfile()),
          GoRoute(
              path: MobileRoutes.candidateApplications,
              builder: (context, state) => const ApplicationTracker()),
          GoRoute(
              path: MobileRoutes.candidateAppTimeline,
              builder: (context, state) => const ApplicationTimelineScreen()),
          GoRoute(
              path: MobileRoutes.candidateEditProfile,
              builder: (context, state) => const EditProfileScreen()),
          GoRoute(
              path: MobileRoutes.candidateSettings,
              builder: (context, state) => const SettingsScreen()),
          GoRoute(
              path: MobileRoutes.candidateJobDetail,
              builder: (context, state) => const CandidateJobDetail()),
          GoRoute(
              path: MobileRoutes.candidateAssessment,
              builder: (context, state) => const SkillAssessmentScreen()),
          GoRoute(
              path: MobileRoutes.candidateAssessmentResult,
              builder: (context, state) => const AssessmentResultsScreen()),
          GoRoute(
              path: MobileRoutes.candidateRoadmap,
              builder: (context, state) => const CareerRoadmap()),
          GoRoute(
              path: MobileRoutes.candidateCVPreview,
              builder: (context, state) => const CVPreviewScreen()),
          GoRoute(
              path: MobileRoutes.candidateVideoPitch,
              builder: (context, state) => const VideoPitchScreen()),
          GoRoute(
              path: MobileRoutes.candidateGigFeed,
              builder: (context, state) => const CandidateGigFeed()),
          GoRoute(
            path: MobileRoutes.candidateGigDetail,
            builder: (context, state) =>
                CandidateGigDetail(gigId: state.pathParameters['id'] ?? 'g1'),
          ),
          GoRoute(
              path: MobileRoutes.candidatePassportProcessing,
              builder: (context, state) => const PassportIQProcessingScreen()),
          GoRoute(
              path: MobileRoutes.candidatePassportResult,
              builder: (context, state) => const PassportIQResultScreen()),
          GoRoute(
              path: MobileRoutes.candidateUplift,
              builder: (context, state) => const UpliftIQScreen()),
          GoRoute(
              path: MobileRoutes.candidateWildcard,
              builder: (context, state) => const WildcardScoreDetail()),

          // New Candidate Screens
          GoRoute(
              path: MobileRoutes.candidateBillingSettings,
              builder: (context, state) => const CandidateBillingSettings()),
          GoRoute(
              path: MobileRoutes.candidateCompleteProfile,
              builder: (context, state) => const CandidateCompleteProfile()),
          GoRoute(
              path: MobileRoutes.candidateForgeIq,
              builder: (context, state) => const CandidateForgeIq()),
          GoRoute(
              path: MobileRoutes.candidateInterviewPrep,
              builder: (context, state) => const CandidateInterviewPrep()),
          GoRoute(
              path: MobileRoutes.candidateMatchIqExplanation,
              builder: (context, state) => const CandidateMatchIqExplanation()),
          GoRoute(
              path: MobileRoutes.candidateMessagesInbox,
              builder: (context, state) => const CandidateMessagesInbox()),
          GoRoute(
              path: MobileRoutes.candidateNotifications,
              builder: (context, state) => const CandidateNotifications()),
          GoRoute(
              path: MobileRoutes.candidateOnboardingWelcome,
              builder: (context, state) => const CandidateOnboardingWelcome()),
          GoRoute(
              path: MobileRoutes.candidatePrivacySettings,
              builder: (context, state) => const CandidatePrivacySettings()),
          GoRoute(
              path: MobileRoutes.candidatePublicProfile,
              builder: (context, state) => const CandidatePublicProfile()),
          GoRoute(
              path: MobileRoutes.candidateReferral,
              builder: (context, state) => const CandidateReferral()),
          GoRoute(
              path: MobileRoutes.candidateSecuritySettings,
              builder: (context, state) => const CandidateSecuritySettings()),
        ],
      ),

      // Shell 2: Employer
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(title: 'Employer', role: UserRole.employer, child: child),
        routes: [
          GoRoute(
              path: MobileRoutes.employerDashboard,
              builder: (context, state) => const EmployerDashboard()),
          GoRoute(
              path: MobileRoutes.employerEnterprise,
              builder: (context, state) => const EnterpriseDashboard()),
          GoRoute(
              path: MobileRoutes.employerJobs,
              builder: (context, state) => const EmployerMyJobs()),
          GoRoute(
              path: MobileRoutes.employerPostJob,
              builder: (context, state) => const EmployerPostJob()),
          GoRoute(
              path: MobileRoutes.employerSettings,
              builder: (context, state) => const SettingsScreen()),
          GoRoute(
              path: MobileRoutes.employerAnalytics,
              builder: (context, state) => const EmployerAnalytics()),
          GoRoute(
              path: MobileRoutes.employerTeam,
              builder: (context, state) => const EmployerTeamManagement()),
          GoRoute(
              path: MobileRoutes.employerPayments,
              builder: (context, state) => const ReleasePaymentScreen()),
          GoRoute(
              path: MobileRoutes.employerDispute,
              builder: (context, state) => const OpenDisputeScreen()),
          GoRoute(
              path: MobileRoutes.employerReview,
              builder: (context, state) => const LeaveReviewScreen()),

          // New Employer Screens
          GoRoute(
              path: MobileRoutes.employerBilling,
              builder: (context, state) => const EmployerBilling()),
          GoRoute(
              path: MobileRoutes.employerCandidates,
              builder: (context, state) => const EmployerCandidates()),
          GoRoute(
              path: MobileRoutes.employerCandidatePipeline,
              builder: (context, state) => const EmployerCandidatePipeline()),
          GoRoute(
              path: MobileRoutes.employerCandidateSearch,
              builder: (context, state) => const EmployerCandidateSearch()),
          GoRoute(
              path: MobileRoutes.employerCompanyProfile,
              builder: (context, state) => const EmployerCompanyProfile()),
          GoRoute(
              path: MobileRoutes.employerDiversityReport,
              builder: (context, state) => const EmployerDiversityReport()),
          GoRoute(
              path: MobileRoutes.employerInterviewDetail,
              builder: (context, state) => const EmployerInterviewDetail()),
          GoRoute(
              path: MobileRoutes.employerInterviewScheduler,
              builder: (context, state) => const EmployerInterviewScheduler()),
          GoRoute(
              path: MobileRoutes.employerLogin,
              builder: (context, state) => const EmployerLogin()),
          GoRoute(
              path: MobileRoutes.employerOfferManagement,
              builder: (context, state) => const EmployerOfferManagement()),
          GoRoute(
              path: MobileRoutes.employerOnboardingSteps,
              builder: (context, state) => const EmployerOnboardingSteps()),
          GoRoute(
              path: MobileRoutes.employerPostGig,
              builder: (context, state) => const EmployerPostGig()),
          GoRoute(
              path: MobileRoutes.employerShortlist,
              builder: (context, state) => const EmployerShortlist()),
          GoRoute(
              path: MobileRoutes.employerSignalIq,
              builder: (context, state) => const EmployerSignalIq()),
          GoRoute(
              path: MobileRoutes.employerWildcardIq,
              builder: (context, state) => const EmployerWildcardIq()),
        ],
      ),

      // Shell 3: Recruiter
      ShellRoute(
        builder: (context, state, child) => MainShell(
            title: 'Recruiter', role: UserRole.recruiter, child: child),
        routes: [
          GoRoute(
              path: MobileRoutes.recruiterDashboard,
              builder: (context, state) => const RecruiterDashboard()),
          GoRoute(
              path: MobileRoutes.recruiterPipeline,
              builder: (context, state) => const RecruiterPipeline()),
          GoRoute(
              path: MobileRoutes.recruiterBriefs,
              builder: (context, state) => const RecruiterBriefs()),
          GoRoute(
              path: MobileRoutes.recruiterSignalIQ,
              builder: (context, state) => const SignalIQReport()),
          GoRoute(
              path: MobileRoutes.recruiterShortlist,
              builder: (context, state) => const RecruiterShortlist()),
          GoRoute(
              path: MobileRoutes.recruiterDiversity,
              builder: (context, state) => const EnterpriseDiversityReport()),
          GoRoute(
              path: MobileRoutes.recruiterCsh,
              builder: (context, state) => const RecruiterCVVault()),
          GoRoute(
              path: MobileRoutes.recruiterSettings,
              builder: (context, state) => const RecruiterSettings()),

          // New Recruiter Screens
          GoRoute(
              path: MobileRoutes.recruiterBriefBuilder,
              builder: (context, state) => const RecruiterBriefBuilder()),
          GoRoute(
              path: MobileRoutes.recruiterCandidateSearch,
              builder: (context, state) => const RecruiterCandidateSearch()),
          GoRoute(
              path: MobileRoutes.recruiterCandidateSubmission,
              builder: (context, state) =>
                  const RecruiterCandidateSubmission()),
          GoRoute(
              path: MobileRoutes.recruiterClientManagement,
              builder: (context, state) => const RecruiterClientManagement()),
          GoRoute(
              path: MobileRoutes.recruiterEarningsDashboard,
              builder: (context, state) => const RecruiterEarningsDashboard()),
          GoRoute(
              path: MobileRoutes.recruiterMessages,
              builder: (context, state) => const RecruiterMessages()),
          GoRoute(
              path: MobileRoutes.recruiterPerformanceDashboard,
              builder: (context, state) =>
                  const RecruiterPerformanceDashboard()),
          GoRoute(
              path: MobileRoutes.recruiterPlacementTracker,
              builder: (context, state) => const RecruiterPlacementTracker()),
        ],
      ),

      // --- Web Routes ---
      GoRoute(
          path: '/web/candidate/dashboard-home',
          builder: (context, state) => const CandidateDashboardHomeWeb()),
      GoRoute(
          path: '/web/candidate/job-search',
          builder: (context, state) => const CandidateJobSearchWeb()),
      GoRoute(
          path: '/web/candidate/job-detail',
          builder: (context, state) => const CandidateJobDetailWeb()),
      GoRoute(
          path: '/web/candidate/profile',
          builder: (context, state) => const CandidateProfileWeb()),
      GoRoute(
          path: '/web/candidate/applications',
          builder: (context, state) => const CandidateApplicationsWeb()),
      GoRoute(
          path: '/web/candidate/messages',
          builder: (context, state) => const CandidateMessagesWeb()),
      GoRoute(
          path: '/web/candidate/notifications',
          builder: (context, state) => const CandidateNotificationsWeb()),
      GoRoute(
          path: '/web/candidate/passport-iq',
          builder: (context, state) => const CandidatePassportIqWeb()),
      GoRoute(
          path: '/web/candidate/forge-iq',
          builder: (context, state) => const CandidateForgeIqWeb()),
      GoRoute(
          path: '/web/candidate/uplift-iq',
          builder: (context, state) => const CandidateUpliftIqWeb()),
      GoRoute(
          path: '/web/candidate/matchiq-explanation',
          builder: (context, state) => const CandidateMatchiqExplanationWeb()),
      GoRoute(
          path: '/web/candidate/gig-dashboard',
          builder: (context, state) => const CandidateGigDashboardWeb()),
      GoRoute(
          path: '/web/candidate/career-goals',
          builder: (context, state) => const CandidateCareerGoalsWeb()),
      GoRoute(
          path: '/web/candidate/references',
          builder: (context, state) => const CandidateReferencesWeb()),
      GoRoute(
          path: '/web/candidate/salary-guide',
          builder: (context, state) => const CandidateSalaryGuideWeb()),
      GoRoute(
          path: '/web/candidate/interview-prep',
          builder: (context, state) => const CandidateInterviewPrepWeb()),
      GoRoute(
          path: '/web/candidate/subscription-upgrade',
          builder: (context, state) => const CandidateSubscriptionUpgradeWeb()),
      GoRoute(
          path: '/web/candidate/billing-settings',
          builder: (context, state) => const CandidateBillingSettingsWeb()),
      GoRoute(
          path: '/web/candidate/privacy-settings',
          builder: (context, state) => const CandidatePrivacySettingsWeb()),
      GoRoute(
          path: '/web/candidate/security-settings',
          builder: (context, state) => const CandidateSecuritySettingsWeb()),
      GoRoute(
          path: '/web/candidate/complete-profile',
          builder: (context, state) => const CandidateCompleteProfileWeb()),
      GoRoute(
          path: '/web/candidate/public-profile',
          builder: (context, state) => const CandidatePublicProfileWeb()),
      GoRoute(
          path: '/web/candidate/referral',
          builder: (context, state) => const CandidateReferralWeb()),
      GoRoute(
          path: '/web/candidate/saved-jobs',
          builder: (context, state) => const CandidateSavedJobsWeb()),
      GoRoute(
          path: '/web/candidate/smart-apply',
          builder: (context, state) => const CandidateSmartApplyWeb()),
      GoRoute(
          path: '/web/candidate/onboarding-welcome',
          builder: (context, state) => const CandidateOnboardingWelcomeWeb()),
      GoRoute(
          path: '/web/employer/dashboard',
          builder: (context, state) => const EmployerDashboardWeb()),
      GoRoute(
          path: '/web/employer/search',
          builder: (context, state) => const EmployerCandidateSearchWeb()),
      GoRoute(
          path: '/web/employer/pipeline',
          builder: (context, state) => const EmployerCandidatePipelineWeb()),
      GoRoute(
          path: '/web/employer/shortlist',
          builder: (context, state) => const EmployerShortlistWeb()),
      GoRoute(
          path: '/web/employer/offer-management',
          builder: (context, state) => const EmployerOfferManagementWeb()),
      GoRoute(
          path: '/web/employer/interview-scheduler',
          builder: (context, state) => const EmployerInterviewSchedulerWeb()),
      GoRoute(
          path: '/web/employer/interview-detail',
          builder: (context, state) => const EmployerInterviewDetailWeb()),
      GoRoute(
          path: '/web/employer/post-job',
          builder: (context, state) => const EmployerPostJobWeb()),
      GoRoute(
          path: '/web/employer/my-jobs',
          builder: (context, state) => const EmployerMyJobsWeb()),
      GoRoute(
          path: '/web/employer/analytics',
          builder: (context, state) => const EmployerAnalyticsWeb()),
      GoRoute(
          path: '/web/employer/diversity-report',
          builder: (context, state) => const EmployerDiversityReportWeb()),
      GoRoute(
          path: '/web/employer/wildcard-iq',
          builder: (context, state) => const EmployerWildcardIqWeb()),
      GoRoute(
          path: '/web/employer/signal-iq',
          builder: (context, state) => const EmployerSignalIqWeb()),
      GoRoute(
          path: '/web/employer/billing',
          builder: (context, state) => const EmployerBillingWeb()),
      GoRoute(
          path: '/web/employer/company-profile',
          builder: (context, state) => const EmployerCompanyProfileWeb()),
      GoRoute(
          path: '/web/employer/onboarding',
          builder: (context, state) => const EmployerOnboardingWeb()),
      GoRoute(
          path: '/web/recruiter/dashboard',
          builder: (context, state) => const RecruiterDashboardWeb()),
      GoRoute(
          path: '/web/recruiter/pipeline',
          builder: (context, state) => const RecruiterPipelineWeb()),
      GoRoute(
          path: '/web/recruiter/briefs',
          builder: (context, state) => const RecruiterBriefsWeb()),
      GoRoute(
          path: '/web/recruiter/brief-builder',
          builder: (context, state) => const RecruiterBriefBuilderWeb()),
      GoRoute(
          path: '/web/recruiter/search',
          builder: (context, state) => const RecruiterCandidateSearchWeb()),
      GoRoute(
          path: '/web/recruiter/submission',
          builder: (context, state) => const RecruiterCandidateSubmissionWeb()),
      GoRoute(
          path: '/web/recruiter/placement-tracker',
          builder: (context, state) => const RecruiterPlacementTrackerWeb()),
      GoRoute(
          path: '/web/recruiter/earnings-dashboard',
          builder: (context, state) => const RecruiterEarningsDashboardWeb()),
      GoRoute(
          path: '/web/recruiter/client-management',
          builder: (context, state) => const RecruiterClientManagementWeb()),
      GoRoute(
          path: '/web/recruiter/performance-dashboard',
          builder: (context, state) =>
              const RecruiterPerformanceDashboardWeb()),
      GoRoute(
          path: '/web/recruiter/cv-vault',
          builder: (context, state) => const RecruiterCvVaultWeb()),
      GoRoute(
          path: '/web/recruiter/settings',
          builder: (context, state) => const RecruiterSettingsWeb()),
      GoRoute(
          path: '/web/admin/dashboard',
          builder: (context, state) => const AdminDashboardWeb()),
      GoRoute(
          path: '/web/admin/users',
          builder: (context, state) => const AdminUsersWeb()),
      GoRoute(
          path: '/web/admin/employer-management',
          builder: (context, state) => const AdminEmployerManagementWeb()),
      GoRoute(
          path: '/web/admin/recruiter-management',
          builder: (context, state) => const AdminRecruiterManagementWeb()),
      GoRoute(
          path: '/web/admin/content-moderation',
          builder: (context, state) => const AdminContentModerationWeb()),
      GoRoute(
          path: '/web/admin/platform-analytics',
          builder: (context, state) => const AdminPlatformAnalyticsWeb()),
      GoRoute(
          path: '/web/admin/system-settings',
          builder: (context, state) => const AdminSystemSettingsWeb()),
      GoRoute(path: '/', builder: (context, state) => const LandingPage()),
      GoRoute(
          path: '/pricing', builder: (context, state) => const PricingPage()),
      GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
      GoRoute(
          path: '/contact', builder: (context, state) => const ContactPage()),
      GoRoute(path: '/blog', builder: (context, state) => const BlogPage()),
      GoRoute(
          path: '/system-status',
          builder: (context, state) => const SystemStatusPage()),
      GoRoute(
          path: '/error-404',
          builder: (context, state) => const Error404Page()),
      GoRoute(
          path: '/thundafund-landing',
          builder: (context, state) => const ThundafundLanding()),
      GoRoute(
          path: '/thundafund-rewards',
          builder: (context, state) => const ThundafundRewards()),
      GoRoute(
          path: '/thundafund-story',
          builder: (context, state) => const ThundafundStory()),
      GoRoute(
          path: '/thundafund-social-proof',
          builder: (context, state) => const ThundafundSocialProof()),
      GoRoute(
          path: '/thundafund-faq',
          builder: (context, state) => const ThundafundFaq()),
      GoRoute(
          path: '/thundafund-updates',
          builder: (context, state) => const ThundafundUpdates()),

      // Shell 4: Admin
      ShellRoute(
        builder: (context, state, child) => MainShell(
            title: 'System Admin', role: UserRole.admin, child: child),
        routes: [
          GoRoute(
              path: MobileRoutes.adminDashboard,
              builder: (context, state) => const AdminDashboard()),
          GoRoute(
              path: MobileRoutes.adminUsers,
              builder: (context, state) => const AdminUsersManagement()),
          GoRoute(
              path: MobileRoutes.adminRevenue,
              builder: (context, state) => const AdminRevenueDashboard()),
          GoRoute(
              path: MobileRoutes.adminSystemHealth,
              builder: (context, state) => const AdminSystemHealth()),

          // New Admin Screens
          GoRoute(
              path: MobileRoutes.adminContentModeration,
              builder: (context, state) => const AdminContentModeration()),
          GoRoute(
              path: MobileRoutes.adminEmployerManagement,
              builder: (context, state) => const AdminEmployerManagement()),
          GoRoute(
              path: MobileRoutes.adminPlatformAnalytics,
              builder: (context, state) => const AdminPlatformAnalytics()),
          GoRoute(
              path: MobileRoutes.adminRecruiterManagement,
              builder: (context, state) => const AdminRecruiterManagement()),
          GoRoute(
              path: MobileRoutes.adminSystemSettings,
              builder: (context, state) => const AdminSystemSettings()),
        ],
      ),
    ],
  );
});

/// A shared shell layout that wraps the child widget.
class MainShell extends StatelessWidget {
  final Widget child;
  final String title;
  final UserRole role;

  const MainShell({
    super.key,
    required this.child,
    required this.title,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: RoleNavigationBar(role: role),
    );
  }
}
