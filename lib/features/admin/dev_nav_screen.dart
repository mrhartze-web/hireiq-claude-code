import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';

// ── Data model ────────────────────────────────────────────────────────────────

class _PageEntry {
  const _PageEntry(this.name, this.route);
  final String name;
  final String route;
}

class _Section {
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.pages,
    this.comingSoon = false,
  });
  final String title;
  final IconData icon;
  final Color color;
  final List<_PageEntry> pages;
  final bool comingSoon;
}

// ── Page catalogue ────────────────────────────────────────────────────────────

const _sections = <_Section>[
  _Section(
    title: 'Public',
    icon: Icons.public_rounded,
    color: Color(0xFF64748B),
    pages: [
      _PageEntry('Splash', '/'),
      _PageEntry('Welcome', '/welcome'),
      _PageEntry('Landing Page', '/landing'),
      _PageEntry('Web Pricing', '/pricing'),
      _PageEntry('Mobile Pricing', '/pricing-plans'),
      _PageEntry('About', '/about'),
      _PageEntry('Contact', '/contact'),
      _PageEntry('Blog', '/blog'),
      _PageEntry('System Status', '/status'),
      _PageEntry('Login', '/login'),
      _PageEntry('Signup', '/signup'),
      _PageEntry('Role Selection', '/role-selection'),
      _PageEntry('Forgot Password', '/forgot-password'),
      _PageEntry('OTP Verification', '/otp-verification'),
      _PageEntry('POPIA Consent', '/popia-consent'),
      _PageEntry('Maintenance', '/maintenance'),
      _PageEntry('No Internet', '/no-internet'),
      _PageEntry('App Update', '/app-update'),
      _PageEntry('Payment Failed', '/payment-failed'),
      _PageEntry('Subscription Expired', '/subscription-expired'),
      _PageEntry('Profile Under Review', '/profile-under-review'),
      _PageEntry('Generic Error', '/error'),
    ],
  ),
  _Section(
    title: 'Candidate',
    icon: Icons.person_rounded,
    color: HireIQTheme.primaryTeal,
    pages: [
      _PageEntry('Candidate Dashboard', '/candidate'),
      _PageEntry('Dashboard Home', '/candidate/home'),
      _PageEntry('Job Feed', '/candidate/jobs'),
      _PageEntry('Profile', '/candidate/profile'),
      _PageEntry('Application Tracker', '/candidate/applications'),
      _PageEntry('Saved Jobs', '/candidate/saved-jobs'),
      _PageEntry('Messages', '/candidate/messages'),
      _PageEntry('Notifications', '/candidate/notifications'),
      _PageEntry('Smart Apply', '/candidate/smart-apply'),
      _PageEntry('MatchIQ Explanation', '/candidate/matchiq'),
      _PageEntry('PassportIQ', '/candidate/passport-iq'),
      _PageEntry('ForgeIQ CV Builder', '/candidate/forge-iq'),
      _PageEntry('UpliftIQ', '/candidate/uplift-iq'),
      _PageEntry('Career Goals', '/candidate/career-goals'),
      _PageEntry('Career Roadmap', '/candidate/roadmap'),
      _PageEntry('References', '/candidate/references'),
      _PageEntry('Salary Guide', '/candidate/salary-guide'),
      _PageEntry('Interview Prep', '/candidate/interview-prep'),
      _PageEntry('Referral Programme', '/candidate/referral'),
      _PageEntry('Billing Settings', '/candidate/billing'),
      _PageEntry('Security Settings', '/candidate/security'),
      _PageEntry('Privacy Settings', '/candidate/privacy'),
      _PageEntry('Complete Profile', '/candidate/complete-profile'),
      _PageEntry('Public Profile', '/candidate/public-profile'),
      _PageEntry('Subscription Upgrade', '/candidate/subscription'),
      _PageEntry('Onboarding Welcome', '/candidate/onboarding-welcome'),
      _PageEntry('CV Upload', '/candidate/cv-upload'),
      _PageEntry('CV Preview', '/candidate/cv-preview'),
      _PageEntry('Edit Profile', '/candidate/edit-profile'),
      _PageEntry('Wildcard Score', '/candidate/wildcard'),
      _PageEntry('Gig Feed', '/candidate/gigs'),
      _PageEntry('Application Timeline', '/candidate/timeline'),
      _PageEntry('MatchIQ Processing', '/matchiq-processing'),
      _PageEntry('ForgeIQ Generating', '/forge-iq-generating'),
      _PageEntry('ForgeIQ Cover Letter', '/forge-iq-cover-letter'),
      _PageEntry('UpliftIQ Generating', '/uplift-iq-generating'),
      _PageEntry('Active Contract', '/gig-active-contract'),
      _PageEntry('Milestone Detail', '/gig-milestone'),
      _PageEntry('Raise Dispute', '/gig-dispute'),
      _PageEntry('Leave Review', '/gig-review'),
      _PageEntry('Freelancer Profile', '/gig-freelancer-profile'),
      _PageEntry('Referral Invite', '/candidate/referral-invite'),
      _PageEntry('Rewards History', '/candidate/referral-history'),
      _PageEntry('Rewards Redeem', '/candidate/referral-redeem'),
    ],
  ),
  _Section(
    title: 'Employer',
    icon: Icons.business_rounded,
    color: HireIQTheme.primaryNavy,
    pages: [
      _PageEntry('Employer Dashboard', '/employer'),
      _PageEntry('My Jobs', '/employer/my-jobs'),
      _PageEntry('Post a Job', '/employer/post-job'),
      _PageEntry('Candidate Pool', '/employer/candidates'),
      _PageEntry('Candidate Search', '/employer/candidate-search'),
      _PageEntry('Candidate Pipeline', '/employer/pipeline'),
      _PageEntry('Shortlist', '/employer/shortlist'),
      _PageEntry('Offer Management', '/employer/offers'),
      _PageEntry('Interview Scheduler', '/employer/interviews'),
      _PageEntry('WildcardIQ Setup', '/employer/wildcard-iq'),
      _PageEntry('SignalIQ Report', '/employer/signal-iq'),
      _PageEntry('Analytics', '/employer/analytics'),
      _PageEntry('Billing', '/employer/billing'),
      _PageEntry('Company Profile', '/employer/company-profile'),
      _PageEntry('Employer Onboarding', '/employer/onboarding'),
      _PageEntry('Post a Gig', '/employer/post-gig'),
      _PageEntry('Diversity Report', '/employer/diversity'),
      _PageEntry('Payments', '/employer/payments'),
      _PageEntry('Team Management', '/employer/team'),
      _PageEntry('Enterprise Dashboard', '/employer/enterprise'),
      _PageEntry('Confirm Hire', '/employer/confirm-hire'),
      _PageEntry('Invoices', '/employer/invoices'),
      _PageEntry('Gig Proposals', '/employer/gig-proposals'),
    ],
  ),
  _Section(
    title: 'Recruiter',
    icon: Icons.handshake_rounded,
    color: Color(0xFF7C3AED),
    pages: [
      _PageEntry('Recruiter Dashboard', '/recruiter'),
      _PageEntry('Pipeline', '/recruiter/pipeline'),
      _PageEntry('Briefs', '/recruiter/briefs'),
      _PageEntry('Brief Builder', '/recruiter/brief-builder'),
      _PageEntry('Candidate Search', '/recruiter/candidate-search'),
      _PageEntry('Candidate Submission', '/recruiter/submission'),
      _PageEntry('CV Vault', '/recruiter/cv-vault'),
      _PageEntry('Shortlist', '/recruiter/shortlist'),
      _PageEntry('Placement Tracker', '/recruiter/placement-tracker'),
      _PageEntry('Earnings Dashboard', '/recruiter/earnings'),
      _PageEntry('Client Management', '/recruiter/client-management'),
      _PageEntry('Performance Dashboard', '/recruiter/performance'),
      _PageEntry('Messages', '/recruiter/messages'),
      _PageEntry('SignalIQ Report', '/recruiter/signal-iq'),
      _PageEntry('Settings', '/recruiter/settings'),
      _PageEntry('Onboarding Step 1', '/recruiter/onboarding-1'),
      _PageEntry('Onboarding Step 2', '/recruiter/onboarding-2'),
      _PageEntry('Onboarding Step 3', '/recruiter/onboarding-3'),
      _PageEntry('ShieldIQ Flag', '/recruiter/shield-iq'),
    ],
  ),
  _Section(
    title: 'Admin',
    icon: Icons.shield_rounded,
    color: Color(0xFF94A3B8),
    pages: [
      _PageEntry('Admin Dashboard', '/admin'),
      _PageEntry('User Management', '/admin/users'),
      _PageEntry('Employer Management', '/admin/employer-management'),
      _PageEntry('Recruiter Management', '/admin/recruiter-management'),
      _PageEntry('Content Moderation', '/admin/content-moderation'),
      _PageEntry('Platform Analytics', '/admin/platform-analytics'),
      _PageEntry('Revenue Dashboard', '/admin/revenue'),
      _PageEntry('System Health', '/admin/system-health'),
      _PageEntry('System Settings', '/admin/system-settings'),
    ],
  ),
  _Section(
    title: 'Enterprise',
    icon: Icons.corporate_fare_rounded,
    color: Color(0xFF0EA5E9),
    comingSoon: true,
    pages: [
      _PageEntry('Team Management', '/enterprise/team'),
      _PageEntry('API Portal', '/enterprise/api-portal'),
      _PageEntry('API Keys', '/enterprise/api-keys'),
      _PageEntry('White Label', '/enterprise/white-label'),
      _PageEntry('HRIS Integrations', '/enterprise/hris'),
      _PageEntry('Analytics Suite', '/enterprise/analytics'),
      _PageEntry('Employer Brand', '/enterprise/employer-brand'),
      _PageEntry('Hiring Workflow', '/enterprise/hiring-workflow'),
      _PageEntry('Bulk CV Review', '/enterprise/bulk-review'),
      _PageEntry('Compliance', '/enterprise/compliance'),
      _PageEntry('Job Approval', '/enterprise/job-approval'),
      _PageEntry('Contracts', '/enterprise/contracts'),
      _PageEntry('SLA Dashboard', '/enterprise/sla'),
      _PageEntry('Enterprise Onboarding', '/enterprise/onboarding'),
      _PageEntry('Enterprise Billing', '/enterprise/billing'),
      _PageEntry('Support Portal', '/enterprise/support'),
    ],
  ),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class DevNavScreen extends StatefulWidget {
  const DevNavScreen({super.key});

  @override
  State<DevNavScreen> createState() => _DevNavScreenState();
}

class _DevNavScreenState extends State<DevNavScreen> {
  String _query = '';
  final Map<String, bool> _expanded = {};

  int get _totalPages =>
      _sections.fold(0, (sum, s) => sum + s.pages.length);

  List<_Section> get _filtered {
    if (_query.isEmpty) return _sections;
    final q = _query.toLowerCase();
    return _sections
        .map((s) {
          final pages = s.pages
              .where((p) =>
                  p.name.toLowerCase().contains(q) ||
                  p.route.toLowerCase().contains(q))
              .toList();
          if (pages.isEmpty) return null;
          return _Section(
            title: s.title,
            icon: s.icon,
            color: s.color,
            pages: pages,
            comingSoon: s.comingSoon,
          );
        })
        .whereType<_Section>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── App bar ──────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  'Page Directory',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  '$_totalPages pages across ${_sections.length} sections',
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.65)),
                ),
              ],
            ),
          ),

          // ── Search bar ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusLg),
                  border: Border.all(color: HireIQTheme.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  style: GoogleFonts.inter(
                      fontSize: 14, color: HireIQTheme.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search pages or routes…',
                    hintStyle: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textLight),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: HireIQTheme.textMuted, size: 20),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: HireIQTheme.textMuted, size: 18),
                            onPressed: () => setState(() => _query = ''),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ),

          // ── Sections ─────────────────────────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final section = filtered[index];
                final isExpanded =
                    _expanded[section.title] ??
                        (_query.isNotEmpty ? true : index == 0);
                return _SectionCard(
                  section: section,
                  isExpanded: isExpanded,
                  onToggle: () => setState(() =>
                      _expanded[section.title] = !isExpanded),
                  onLaunch: (route) => context.push(route),
                );
              },
              childCount: filtered.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ── Section card ───────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.isExpanded,
    required this.onToggle,
    required this.onLaunch,
  });

  final _Section section;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String route) onLaunch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(HireIQTheme.radiusLg),
              bottom: isExpanded
                  ? Radius.zero
                  : const Radius.circular(HireIQTheme.radiusLg),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: section.color.withValues(alpha: 0.12),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                    child: Icon(section.icon,
                        color: section.color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          section.title,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy),
                        ),
                        if (section.comingSoon) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: section.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                            ),
                            child: Text(
                              'Coming Soon',
                              style: GoogleFonts.inter(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: section.color),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: section.color.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                    ),
                    child: Text(
                      '${section.pages.length}',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: section.color),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: HireIQTheme.textMuted, size: 20),
                  ),
                ],
              ),
            ),
          ),

          // ── Page list ────────────────────────────────────────────────────
          if (isExpanded) ...[
            Container(height: 1, color: HireIQTheme.borderLight),
            ...section.pages.asMap().entries.map((entry) {
              final isLast = entry.key == section.pages.length - 1;
              return _PageRow(
                entry: entry.value,
                isLast: isLast,
                comingSoon: section.comingSoon,
                onLaunch: () => onLaunch(entry.value.route),
              );
            }),
          ],
        ],
      ),
    );
  }
}

// ── Page row ───────────────────────────────────────────────────────────────────

class _PageRow extends StatelessWidget {
  const _PageRow({
    required this.entry,
    required this.isLast,
    required this.comingSoon,
    required this.onLaunch,
  });

  final _PageEntry entry;
  final bool isLast;
  final bool comingSoon;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: HireIQTheme.borderLight)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.route,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      color: HireIQTheme.textLight),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: comingSoon ? null : onLaunch,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: comingSoon
                    ? HireIQTheme.borderLight
                    : HireIQTheme.primaryTeal,
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              child: Text(
                comingSoon ? 'Soon' : 'Launch',
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: comingSoon
                        ? HireIQTheme.textMuted
                        : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
