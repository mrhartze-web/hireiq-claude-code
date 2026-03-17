// HireIQ Mobile Screens Registry
// This file maps screen classes to their respective routes.

class MobileRoutes {
  // Public & Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String emailVerification = '/email-verification';
  static const String socialAuthLoading = '/auth-loading';
  static const String forgotPassword = '/forgot-password';
  static const String passwordResetSuccess = '/password-reset-success';
  static const String roleSelection = '/role-selection';
  static const String pricing = '/pricing';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String messages = '/messages';
  static const String messageThread = '/messages/:id';
  static const String phoneVerification = '/verify-phone';

  // Candidate Section
  static const String candidateDashboard = '/candidate';
  static const String candidateJobFeed = '/candidate/jobs';
  static const String candidateJobDetail = '/candidate/jobs/:id';
  static const String candidateProfile = '/candidate/profile';
  static const String candidateEditProfile = '/candidate/edit-profile';
  static const String candidateApplications = '/candidate/applications';
  static const String candidateAppTimeline = '/candidate/applications/:id';
  static const String candidateSettings = '/candidate/settings';
  static const String candidateGigFeed = '/candidate/gigs';
  static const String candidateGigDetail = '/candidate/gigs/:id';
  static const String candidatePassportProcessing =
      '/candidate/passport/processing';
  static const String candidatePassportResult = '/candidate/passport/result';
  static const String candidateUplift = '/candidate/uplift';
  static const String candidateUpliftProcessing =
      '/candidate/uplift/processing';
  static const String candidateAssessment = '/candidate/assessment';
  static const String candidateAssessmentResult =
      '/candidate/assessment-result';
  static const String candidateRoadmap = '/candidate/roadmap';
  static const String candidateCVPreview = '/candidate/cv-preview';
  static const String candidateVideoPitch = '/candidate/video-pitch';
  static const String candidateWildcard = '/candidate/wildcard';

  // Employer Section
  static const String employerDashboard = '/employer';
  static const String employerEnterprise = '/employer/enterprise';
  static const String employerJobs = '/employer/my-jobs';
  static const String employerPostJob = '/employer/post-job';
  static const String employerCandidates = '/employer/candidates';
  static const String employerAnalytics = '/employer/analytics';
  static const String employerSettings = '/employer/settings';
  static const String employerTeam = '/employer/team';
  static const String employerPayments = '/employer/payments';
  static const String employerDispute = '/employer/dispute';
  static const String employerReview = '/employer/review';

  // Recruiter Section
  static const String recruiterDashboard = '/recruiter';
  static const String recruiterPipeline = '/recruiter/pipeline';
  static const String recruiterBriefs = '/recruiter/briefs';
  static const String recruiterSignalIQ = '/recruiter/signals';
  static const String recruiterShortlist = '/recruiter/shortlist';
  static const String recruiterDiversity = '/recruiter/diversity';
  static const String recruiterCsh = '/recruiter/cv-vault';
  static const String recruiterSettings = '/recruiter/settings';

  // Admin Section
  static const String adminDashboard = '/admin';
  static const String adminUsers = '/admin/users';
  static const String adminModeration = '/admin/moderation';
  static const String adminRevenue = '/admin/revenue';
  static const String adminSystemHealth = '/admin/health';
  static const String applicationTimelineScreen =
      '/candidate/application-timeline-screen';
  static const String assessmentResultsScreen = '/candidate/assessment-results';
  static const String applicationTracker =
      '/candidate/candidate-application-tracker';
  static const String candidateBillingSettings =
      '/candidate/candidate-billing-settings';
  static const String candidateCareerGoals =
      '/candidate/candidate-career-goals';
  static const String candidateCompleteProfile =
      '/candidate/candidate-complete-profile';
  static const String candidateCVUpload = '/candidate/candidate-cv-upload';
  static const String candidateDashboardHome =
      '/candidate/candidate-dashboard-home';
  static const String candidateForgeIq = '/candidate/candidate-forge-iq';
  static const String candidateInterviewPrep =
      '/candidate/candidate-interview-prep';
  static const String candidateMatchIqExplanation =
      '/candidate/candidate-matchiq-explanation';
  static const String candidateMessagesInbox =
      '/candidate/candidate-messages-inbox';
  static const String candidateNotifications =
      '/candidate/candidate-notifications';
  static const String candidateOnboardingWelcome =
      '/candidate/candidate-onboarding-welcome';
  static const String candidatePrivacySettings =
      '/candidate/candidate-privacy-settings';
  static const String candidatePublicProfile =
      '/candidate/candidate-public-profile';
  static const String candidateReferences = '/candidate/candidate-references';
  static const String candidateReferral = '/candidate/candidate-referral';
  static const String candidateSalaryGuide =
      '/candidate/candidate-salary-guide';
  static const String candidateSavedJobs = '/candidate/candidate-saved-jobs';
  static const String candidateSecuritySettings =
      '/candidate/candidate-security-settings';
  static const String candidateSmartApply = '/candidate/candidate-smart-apply';
  static const String candidateSubscriptionUpgrade =
      '/candidate/candidate-subscription-upgrade';
  static const String careerRoadmap = '/candidate/career-roadmap';
  static const String cVPreviewScreen = '/candidate/cv-preview-screen';
  static const String editProfileScreen = '/candidate/edit-profile-screen';
  static const String passportIQProcessingScreen =
      '/candidate/passport-iq-screens';
  static const String skillAssessmentScreen = '/candidate/skill-assessment';
  static const String upliftIQScreen = '/candidate/uplift-iq-screen';
  static const String videoPitchScreen = '/candidate/video-pitch';
  static const String wildcardScoreDetail = '/candidate/wildcard-score-detail';
  static const String employerBilling = '/employer/employer-billing';
  static const String employerCandidatePipeline =
      '/employer/employer-candidate-pipeline';
  static const String employerCandidateSearch =
      '/employer/employer-candidate-search';
  static const String employerCompanyProfile =
      '/employer/employer-company-profile';
  static const String openDisputeScreen = '/employer/employer-dispute';
  static const String employerDiversityReport =
      '/employer/employer-diversity-report';
  static const String employerInterviewDetail =
      '/employer/employer-interview-detail';
  static const String employerInterviewScheduler =
      '/employer/employer-interview-scheduler';
  static const String employerMyJobs = '/employer/employer-jobs';
  static const String employerLogin = '/employer/employer-login';
  static const String employerOfferManagement =
      '/employer/employer-offer-management';
  static const String employerOnboardingSteps =
      '/employer/employer-onboarding-steps';
  static const String releasePaymentScreen = '/employer/employer-payments';
  static const String employerPostGig = '/employer/employer-post-gig';
  static const String employerShortlist = '/employer/employer-shortlist';
  static const String employerSignalIq = '/employer/employer-signal-iq';
  static const String employerTeamManagement =
      '/employer/employer-team-management';
  static const String employerWildcardIq = '/employer/employer-wildcard-iq';
  static const String enterpriseDashboard = '/employer/enterprise-dashboard';
  static const String leaveReviewScreen = '/employer/leave-review';
  static const String enterpriseDiversityReport =
      '/recruiter/enterprise-diversity-report';
  static const String recruiterBriefBuilder =
      '/recruiter/recruiter-brief-builder';
  static const String recruiterCandidateSearch =
      '/recruiter/recruiter-candidate-search';
  static const String recruiterCandidateSubmission =
      '/recruiter/recruiter-candidate-submission';
  static const String recruiterClientManagement =
      '/recruiter/recruiter-client-management';
  static const String recruiterCVVault = '/recruiter/recruiter-cv-vault';
  static const String recruiterEarningsDashboard =
      '/recruiter/recruiter-earnings-dashboard';
  static const String recruiterMessages = '/recruiter/recruiter-messages';
  static const String recruiterPerformanceDashboard =
      '/recruiter/recruiter-performance-dashboard';
  static const String recruiterPlacementTracker =
      '/recruiter/recruiter-placement-tracker';
  static const String signalIQReport = '/recruiter/signal-iq-report';
  static const String adminContentModeration =
      '/admin/admin-content-moderation';
  static const String adminEmployerManagement =
      '/admin/admin-employer-management';
  static const String adminPlatformAnalytics =
      '/admin/admin-platform-analytics';
  static const String adminRecruiterManagement =
      '/admin/admin-recruiter-management';
  static const String adminRevenueDashboard = '/admin/admin-revenue';
  static const String adminSystemSettings = '/admin/admin-system-settings';
  static const String adminUsersManagement = '/admin/admin-users';
}
