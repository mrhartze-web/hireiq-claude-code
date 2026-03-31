import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../services/firebase/notification_service.dart';
import '../features/mobile_screens.dart';
import '../features/web_screens.dart';
import '../shared/navigation/role_navigation_bar.dart';
import '../shared/components/admin_mode_bar.dart';
import '../shared/theme.dart';

// Import Public & Common Screens
import '../features/public/splash_screen.dart';
import '../features/public/welcome_screen.dart';
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
import '../features/public/otp_verification_screen.dart';
import '../features/public/popia_consent_screen.dart';
import '../features/public/maintenance_screen.dart';
import '../features/public/no_internet_screen.dart';
import '../features/public/app_update_screen.dart';
import '../features/public/payment_failed_screen.dart';
import '../features/public/subscription_expired_screen.dart';
import '../features/public/profile_under_review_screen.dart';
import '../features/public/error_generic_screen.dart';

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
import '../features/candidate/candidate_matchiq_explanation_web.dart';
import '../features/candidate/candidate_messages_inbox.dart';
import '../features/candidate/candidate_notifications.dart';
import '../features/candidate/candidate_onboarding_welcome.dart';
import '../features/candidate/candidate_privacy_settings.dart';
import '../features/candidate/candidate_public_profile.dart';
import '../features/candidate/candidate_referral.dart';
import '../features/candidate/candidate_security_settings.dart';
import '../features/candidate/candidate_dashboard_home.dart';
import '../features/candidate/candidate_career_goals.dart';
import '../features/candidate/candidate_cv_upload.dart';
import '../features/candidate/candidate_salary_guide.dart';
import '../features/candidate/candidate_saved_jobs.dart';
import '../features/candidate/candidate_smart_apply.dart';
import '../features/candidate/candidate_subscription_upgrade.dart';
import '../features/candidate/matchiq_processing_screen.dart';
import '../features/candidate/forge_iq_generating_screen.dart';
import '../features/candidate/forge_iq_cover_letter_screen.dart';
import '../features/candidate/uplift_iq_generating_screen.dart';
import '../features/candidate/referral_invite_screen.dart';
import '../features/candidate/referral_rewards_history_screen.dart';
import '../features/candidate/referral_rewards_redeem_screen.dart';
import '../features/candidate/gig_active_contract_screen.dart';
import '../features/candidate/gig_milestone_screen.dart';
import '../features/candidate/gig_dispute_screen.dart';
import '../features/candidate/gig_review_screen.dart';
import '../features/candidate/gig_freelancer_profile_screen.dart';

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
import '../features/employer/employer_confirm_hire_screen.dart';
import '../features/employer/employer_invoices_screen.dart';
import '../features/employer/gig_proposals_view_screen.dart';
import '../features/employer/enterprise_team_management.dart';
import '../features/employer/enterprise_api_portal.dart';
import '../features/employer/enterprise_api_keys.dart';
import '../features/employer/enterprise_white_label.dart';
import '../features/employer/enterprise_hris_integrations.dart';
import '../features/employer/enterprise_analytics_suite.dart';
import '../features/employer/enterprise_employer_brand.dart';
import '../features/employer/enterprise_hiring_workflow.dart';
import '../features/employer/enterprise_bulk_review.dart';
import '../features/employer/enterprise_compliance.dart';
import '../features/employer/enterprise_job_approval.dart';
import '../features/employer/enterprise_contracts.dart';
import '../features/employer/enterprise_sla.dart';
import '../features/employer/enterprise_onboarding.dart';
import '../features/employer/enterprise_billing.dart';
import '../features/employer/enterprise_support.dart';

// Import Recruiter Screens
import '../features/recruiter/recruiter_dashboard.dart';
import '../features/recruiter/recruiter_pipeline.dart';
import '../features/recruiter/recruiter_briefs.dart';
import '../features/recruiter/recruiter_cv_vault.dart';
import '../features/recruiter/recruiter_settings.dart';
import '../features/recruiter/recruiter_signal_iq_report.dart';
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
import '../features/recruiter/recruiter_onboarding_step1.dart';
import '../features/recruiter/recruiter_onboarding_step2.dart';
import '../features/recruiter/recruiter_onboarding_step3.dart';
import '../features/recruiter/shield_iq_flag_screen.dart';

// Import Admin Screens
import '../features/admin/admin_dashboard.dart';
import '../features/admin/dev_nav_screen.dart';
import '../features/admin/admin_users.dart';
import '../features/admin/admin_revenue.dart';
import '../features/admin/admin_system_health.dart';
import '../features/admin/admin_content_moderation.dart';
import '../features/admin/admin_employer_management.dart';
import '../features/admin/admin_platform_analytics.dart';
import '../features/admin/admin_recruiter_management.dart';
import '../features/admin/admin_system_settings.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Short-path aliases handled in onException because GoRouter's global
  // redirect only fires for registered routes, not unknown paths.
  const _routeAliases = {
    '/candidate/dashboard'    : '/candidate/home',
    '/candidate/match-iq'     : '/candidate/wildcard',
    '/candidate/forge-iq'     : '/candidate/candidate-forge-iq',
    '/candidate/uplift-iq'    : '/candidate/uplift',
    '/candidate/passport-iq'  : '/candidate/passport/processing',
    '/recruiter/brief-builder': '/recruiter/recruiter-brief-builder',
  };

  return GoRouter(
    initialLocation: MobileRoutes.splash,
    debugLogDiagnostics: true,
    onException: (context, state, router) {
      final canonical = _routeAliases[state.uri.path];
      if (canonical != null) {
        router.go(canonical);
      } else {
        router.go('/error-404');
      }
    },
    redirect: (context, state) {
      // ── Use synchronous currentUser — never null while stream warms up ───
      final currentUser = FirebaseAuth.instance.currentUser;
      final isAuth = currentUser != null;
      final path = state.uri.path;

      // ── Routes that never require authentication ───────────────────────────
      const publicRoutes = {
        '/',                         // splash
        '/welcome',
        '/onboarding',               // backwards compat → redirects to /welcome
        '/login',
        '/signup',
        '/forgot-password',
        '/role-selection',
        '/candidate-onboarding',
        '/email-verification',
        '/auth-loading',
        '/password-reset-success',
        '/verify-phone',
        '/terms',
        '/privacy',
        '/pricing-plans',            // mobile pricing
        '/landing',
        '/pricing',                  // web pricing
        '/about',
        '/contact',
        '/blog',
        '/status',
        '/system-status',
        '/error-404',
        '/notifications',
        '/messages',
        // Utility / error screens accessible without auth
        '/otp-verification',
        '/popia-consent',
        '/maintenance',
        '/no-internet',
        '/app-update',
        '/payment-failed',
        '/subscription-expired',
        '/profile-under-review',
        '/error',
      };

      final isProtectedPath = path.startsWith('/candidate') ||
          path.startsWith('/employer') ||
          path.startsWith('/recruiter') ||
          path.startsWith('/admin') ||
          path.startsWith('/enterprise') ||
          path.startsWith('/web/');

      // Dynamic /messages/:id segments are public — same as /messages root.
      // NOTE: /web/* is intentionally excluded — all web shell routes require auth.
      final isPublicRoute = publicRoutes.contains(path) ||
          path.startsWith('/messages/');

      // ── Guard: unauthenticated user → login ──────────────────────────────
      // /web/* routes redirect directly to /login (deep-link friendly).
      // All other protected routes redirect to /welcome (onboarding flow).
      if (!isAuth && (isProtectedPath || !isPublicRoute)) {
        return path.startsWith('/web/') ? '/login' : '/welcome';
      }

      // ── Authenticated user on auth/onboarding screens → role dashboard ───
      // The splash screen handles initial routing; this redirect covers
      // direct URL navigation and post-auth screen returns.
      // NOTE: /role-selection is intentionally excluded so authenticated users
      // can revisit it from settings or profile without being bounced away.
      if (isAuth) {
        final onAuthScreen = path == '/' ||
            path == '/welcome' ||
            path == '/onboarding' ||
            path == '/login' ||
            path == '/signup';

        if (onAuthScreen) {
          // Read the synchronous role cache set by the splash/login/signup
          final cachedRole = ref.read(cachedRoleProvider);
          if (cachedRole == null) return null; // cache not yet populated — stay
          if (cachedRole == 'employer') return '/employer';
          if (cachedRole == 'recruiter') return '/recruiter';
          if (cachedRole == 'admin') return '/admin';
          return '/candidate';
        }

        // ── Cross-role protection (admin exempt — View As feature) ──────────
        final cachedRole = ref.read(cachedRoleProvider);
        if (cachedRole != null && cachedRole != 'admin' && isProtectedPath) {
          if (cachedRole == 'candidate' &&
              !path.startsWith('/candidate') &&
              !path.startsWith('/web/candidate')) {
            return '/candidate';
          }
          if (cachedRole == 'employer' &&
              !path.startsWith('/employer') &&
              !path.startsWith('/enterprise') &&
              !path.startsWith('/web/employer')) {
            return '/employer';
          }
          if (cachedRole == 'recruiter' &&
              !path.startsWith('/recruiter') &&
              !path.startsWith('/web/recruiter')) {
            return '/recruiter';
          }
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
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen()),
      GoRoute(
          path: '/onboarding',
          redirect: (context, state) => '/welcome'),
      GoRoute(
          path: '/candidate-onboarding',
          builder: (context, state) => const CandidateOnboardingFlow()),
      GoRoute(
          path: MobileRoutes.login,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: MobileRoutes.signup,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final role = extra?['role'] as String?;
            final gigFocused = extra?['gigFocused'] as bool? ?? false;
            return SignupScreen(initialRole: role, gigFocused: gigFocused);
          }),
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

      // New Public / System Routes
      GoRoute(
          path: '/otp-verification',
          builder: (context, state) => const OtpVerificationScreen()),
      GoRoute(
          path: '/popia-consent',
          builder: (context, state) => const PopiaConsentScreen()),
      GoRoute(
          path: '/maintenance',
          builder: (context, state) => const MaintenanceScreen()),
      GoRoute(
          path: '/no-internet',
          builder: (context, state) => const NoInternetScreen()),
      GoRoute(
          path: '/app-update',
          builder: (context, state) => const AppUpdateScreen()),
      GoRoute(
          path: '/payment-failed',
          builder: (context, state) => const PaymentFailedScreen()),
      GoRoute(
          path: '/subscription-expired',
          builder: (context, state) => const SubscriptionExpiredScreen()),
      GoRoute(
          path: '/profile-under-review',
          builder: (context, state) => const ProfileUnderReviewScreen()),
      GoRoute(
          path: '/error',
          builder: (context, state) => const ErrorGenericScreen()),

      // Shell 1: Candidate
      ShellRoute(
        builder: (context, state, child) => MainShell(
            title: 'Candidate', role: UserRole.candidate, child: child),
        routes: [
          GoRoute(
              path: MobileRoutes.candidateDashboard,
              builder: (context, state) => const CandidateJobFeed()),
          GoRoute(
              path: MobileRoutes.candidateJobFeed,
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
            builder: (context, state) => const CandidateGigDetail(),
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

          // Routing-audit additions
          GoRoute(
              path: MobileRoutes.candidateHome,
              builder: (context, state) => const CandidateDashboardHome()),
          GoRoute(
              path: MobileRoutes.candidateSavedJobsPath,
              builder: (context, state) => const CandidateSavedJobs()),
          GoRoute(
              path: MobileRoutes.candidateSmartApplyPath,
              builder: (context, state) => const CandidateSmartApply()),
          GoRoute(
              path: MobileRoutes.candidateCareerGoalsPath,
              builder: (context, state) => const CandidateCareerGoals()),
          GoRoute(
              path: MobileRoutes.candidateSalaryGuidePath,
              builder: (context, state) => const CandidateSalaryGuide()),
          GoRoute(
              path: MobileRoutes.candidateSubscriptionPath,
              builder: (context, state) => const CandidateSubscriptionUpgrade()),
          GoRoute(
              path: MobileRoutes.candidateCVUploadPath,
              builder: (context, state) => const CandidateCvUpload()),

          // New Candidate Blueprint Screens
          GoRoute(
              path: '/candidate/matchiq-processing',
              builder: (context, state) => const MatchIQProcessingScreen()),
          GoRoute(
              path: '/candidate/forge-iq-generating',
              builder: (context, state) => const ForgeIQGeneratingScreen()),
          GoRoute(
              path: '/candidate/forge-iq-cover-letter',
              builder: (context, state) => const ForgeIQCoverLetterScreen()),
          GoRoute(
              path: '/candidate/uplift-iq-generating',
              builder: (context, state) => const UpliftIQGeneratingScreen()),
          GoRoute(
              path: '/candidate/referral/invite',
              builder: (context, state) => const ReferralInviteScreen()),
          GoRoute(
              path: '/candidate/referral/rewards-history',
              builder: (context, state) => const ReferralRewardsHistoryScreen()),
          GoRoute(
              path: '/candidate/referral/redeem',
              builder: (context, state) => const ReferralRewardsRedeemScreen()),
          GoRoute(
              path: '/candidate/gig/active-contract',
              builder: (context, state) => const GigActiveContractScreen()),
          GoRoute(
              path: '/candidate/gig/milestone',
              builder: (context, state) => const GigMilestoneScreen()),
          GoRoute(
              path: '/candidate/gig/dispute',
              builder: (context, state) => const GigDisputeScreen()),
          GoRoute(
              path: '/candidate/gig/review',
              builder: (context, state) => const GigReviewScreen()),
          GoRoute(
              path: '/candidate/gig/freelancer/:id',
              builder: (context, state) => const GigFreelancerProfileScreen()),

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
              builder: (context, state) => const EmployerJobs()),
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
              builder: (context, state) => const EmployerPayments()),
          GoRoute(
              path: MobileRoutes.employerDispute,
              builder: (context, state) => const EmployerDispute()),
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

          // New Employer Blueprint Screens
          GoRoute(
              path: '/employer/confirm-hire',
              builder: (context, state) => const EmployerConfirmHireScreen()),
          GoRoute(
              path: '/employer/invoices',
              builder: (context, state) => const EmployerInvoicesScreen()),
          GoRoute(
              path: '/employer/gig/proposals',
              builder: (context, state) => const GigProposalsViewScreen()),

          // Enterprise Screens
          GoRoute(
              path: '/enterprise/team',
              builder: (context, state) => const EnterpriseTeamManagementScreen()),
          GoRoute(
              path: '/enterprise/api-portal',
              builder: (context, state) => const EnterpriseApiPortalScreen()),
          GoRoute(
              path: '/enterprise/api-keys',
              builder: (context, state) => const EnterpriseApiKeysScreen()),
          GoRoute(
              path: '/enterprise/white-label',
              builder: (context, state) => const EnterpriseWhiteLabelScreen()),
          GoRoute(
              path: '/enterprise/hris',
              builder: (context, state) => const EnterpriseHrisIntegrationsScreen()),
          GoRoute(
              path: '/enterprise/analytics-suite',
              builder: (context, state) => const EnterpriseAnalyticsSuiteScreen()),
          GoRoute(
              path: '/enterprise/employer-brand',
              builder: (context, state) => const EnterpriseEmployerBrandScreen()),
          GoRoute(
              path: '/enterprise/workflow',
              builder: (context, state) => const EnterpriseHiringWorkflowScreen()),
          GoRoute(
              path: '/enterprise/bulk-review',
              builder: (context, state) => const EnterpriseBulkReviewScreen()),
          GoRoute(
              path: '/enterprise/compliance',
              builder: (context, state) => const EnterpriseComplianceScreen()),
          GoRoute(
              path: '/enterprise/job-approval',
              builder: (context, state) => const EnterpriseJobApprovalScreen()),
          GoRoute(
              path: '/enterprise/contracts',
              builder: (context, state) => const EnterpriseContractsScreen()),
          GoRoute(
              path: '/enterprise/sla',
              builder: (context, state) => const EnterpriseSlaScreen()),
          GoRoute(
              path: '/enterprise/onboarding',
              builder: (context, state) => const EnterpriseOnboardingScreen()),
          GoRoute(
              path: '/enterprise/billing',
              builder: (context, state) => const EnterpriseBillingScreen()),
          GoRoute(
              path: '/enterprise/support',
              builder: (context, state) => const EnterpriseSupportScreen()),
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
              builder: (context, state) => const RecruiterSignalIqReport()),
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

          // New Recruiter Blueprint Screens
          GoRoute(
              path: '/recruiter/onboarding/step-1',
              builder: (context, state) => const RecruiterOnboardingStep1()),
          GoRoute(
              path: '/recruiter/onboarding/step-2',
              builder: (context, state) => const RecruiterOnboardingStep2()),
          GoRoute(
              path: '/recruiter/onboarding/step-3',
              builder: (context, state) => const RecruiterOnboardingStep3()),
          GoRoute(
              path: '/recruiter/shield-iq-flag',
              builder: (context, state) => const ShieldIqFlagScreen()),

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
          builder: (context, state) => const CandidateMatchIqExplanationWeb()),
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
      // ── Public web pages ────────────────────────────────────────────────────
      GoRoute(
          path: '/landing', builder: (context, state) => const LandingPage()),
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
          path: '/status',
          builder: (context, state) => const SystemStatusPage()),
      GoRoute(
          path: '/error-404',
          builder: (context, state) => const Error404Page()),

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
              builder: (context, state) => const AdminUsers()),
          GoRoute(
              path: MobileRoutes.adminRevenue,
              builder: (context, state) => const AdminRevenue()),
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
          GoRoute(
              path: '/admin/pages',
              builder: (context, state) => const DevNavScreen()),
        ],
      ),
    ],
  );
});

/// A shared shell layout that wraps the child widget.
class MainShell extends ConsumerStatefulWidget {
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
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  bool _notificationsInitialised = false;

  @override
  void initState() {
    super.initState();
    // Defer so ref.listen works after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenForAuth();
    });
  }

  void _listenForAuth() {
    ref.listenManual(authStateProvider, (_, next) {
      final user = next.value;
      if (user != null && !_notificationsInitialised) {
        _notificationsInitialised = true;
        NotificationService().initialise(user.uid);
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(cachedRoleProvider) == 'admin';
    return Scaffold(
      body: isAdmin
          ? Stack(
              children: [
                widget.child,
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AdminModeBar(currentSection: widget.role),
                ),
              ],
            )
          : widget.child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PersonaBar(role: widget.role),
          RoleNavigationBar(role: widget.role),
        ],
      ),
    );
  }
}

class _PersonaBar extends StatelessWidget {
  const _PersonaBar({required this.role});

  final UserRole role;

  String get _persona {
    switch (role) {
      case UserRole.candidate:
        return 'Thabo Nkosi · Senior Flutter Developer';
      case UserRole.employer:
        return 'Nomsa Dlamini · HR Director · FinCorp SA';
      case UserRole.recruiter:
        return 'Riya Patel · Senior Recruiter';
      case UserRole.admin:
        return 'Alan Nkomo · System Administrator';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: const BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: Border(
            top: BorderSide(color: HireIQTheme.borderLight, width: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text(
        _persona,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: HireIQTheme.textMuted),
      ),
    );
  }
}
