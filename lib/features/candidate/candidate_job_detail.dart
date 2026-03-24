import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/job_model.dart';
import '../../providers/job_provider.dart';
import '../../shared/theme.dart';
import '../mobile_screens.dart';

class CandidateJobDetail extends ConsumerStatefulWidget {
  const CandidateJobDetail({super.key});

  @override
  ConsumerState<CandidateJobDetail> createState() => _CandidateJobDetailState();
}

class _CandidateJobDetailState extends ConsumerState<CandidateJobDetail> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final jobId = GoRouterState.of(context).pathParameters['id'] ?? '';
    final jobAsync = ref.watch(jobDetailProvider(jobId));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: jobAsync.when(
        loading: () => _buildLoading(context),
        error: (e, _) => _buildError(context, e.toString()),
        data: (job) {
          if (job == null) return _buildError(context, 'Job not found.');
          return _buildContent(context, job);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, JobModel job) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _JobHeaderCard(job: job),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _buildTabRow(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
                  child: _buildTabBody(job),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _ApplySheet(
        onTap: () => context.push(
          MobileRoutes.candidateSmartApplyPath,
          extra: job.jobId,
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Job Details',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(color: HireIQTheme.primaryTeal),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted, fontSize: 15)),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: HireIQTheme.primaryNavy,
      foregroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share_outlined, size: 20), onPressed: () {}),
        IconButton(icon: const Icon(Icons.bookmark_border_rounded, size: 20), onPressed: () {}),
      ],
      title: Text(
        'Job Details',
        style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget _buildTabRow() {
    const tabs = ['Description', 'Requirements', 'Company'];
    return Row(
      children: List.generate(tabs.length, (i) => Padding(
        padding: EdgeInsets.only(right: i < tabs.length - 1 ? 24 : 0),
        child: GestureDetector(
          onTap: () => setState(() => _selectedTab = i),
          child: _TabItem(label: tabs[i], isActive: _selectedTab == i),
        ),
      )),
    );
  }

  Widget _buildTabBody(JobModel job) {
    switch (_selectedTab) {
      case 0:
        return _buildDescriptionTab(job);
      case 1:
        return _buildRequirementsTab(job);
      case 2:
        return _buildCompanyTab(job);
      default:
        return _buildDescriptionTab(job);
    }
  }

  Widget _buildDescriptionTab(JobModel job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('About the Role'),
        const SizedBox(height: 10),
        Text(
          job.description.isEmpty ? 'No description provided.' : job.description,
          style: GoogleFonts.inter(
              fontSize: 14, color: HireIQTheme.textSecondary, height: 1.7),
        ),
        if (job.skills.isNotEmpty) ...[
          const SizedBox(height: 28),
          _sectionTitle('Skills Required'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: job.skills
                .map((s) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                        border: Border.all(
                            color:
                                HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
                      ),
                      child: Text(s,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: HireIQTheme.primaryTeal,
                              fontWeight: FontWeight.w500)),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildRequirementsTab(JobModel job) {
    final lines = job.requirements
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    if (lines.isEmpty) {
      return Text('No requirements listed.',
          style: GoogleFonts.inter(
              color: HireIQTheme.textMuted, fontSize: 14));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Requirements'),
        const SizedBox(height: 14),
        ...lines.map((l) => _bullet(l)),
      ],
    );
  }

  Widget _buildCompanyTab(JobModel job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Company'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  child: const Icon(Icons.business_rounded,
                      color: HireIQTheme.primaryTeal, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    job.company.isEmpty ? 'Company not specified' : job.company,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy),
                  ),
                ),
              ]),
              const SizedBox(height: 14),
              _infoRow(Icons.work_outline, 'Type', job.jobType),
              if (job.industry.isNotEmpty)
                _infoRow(Icons.domain_outlined, 'Industry', job.industry),
              _infoRow(Icons.location_on_outlined, 'Location', job.location),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          Icon(icon, size: 15, color: HireIQTheme.textMuted),
          const SizedBox(width: 8),
          Text('$label: ',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.textPrimary)),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 13, color: HireIQTheme.textSecondary)),
        ]),
      );

  Widget _sectionTitle(String title) => Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
            letterSpacing: -0.2),
      );

  Widget _bullet(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                    color: HireIQTheme.primaryTeal, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textSecondary,
                      height: 1.65)),
            ),
          ],
        ),
      );
}

// ── Job header card ───────────────────────────────────────────────────────────

class _JobHeaderCard extends StatelessWidget {
  const _JobHeaderCard({required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final salaryLabel = (job.salaryMin > 0 || job.salaryMax > 0)
        ? 'R${_fmt(job.salaryMin)} – R${_fmt(job.salaryMax)}'
        : 'Salary not specified';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                child: const Icon(Icons.rocket_launch_rounded,
                    color: HireIQTheme.primaryTeal, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.company.isEmpty ? 'Company' : job.company,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: HireIQTheme.textMuted,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      job.jobType,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome,
                        size: 12, color: HireIQTheme.primaryTeal),
                    const SizedBox(width: 4),
                    Text('MatchIQ',
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryTeal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            job.title,
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryNavy,
                letterSpacing: -0.5),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(icon: Icons.location_on_outlined, label: job.location),
              _InfoChip(icon: Icons.payments_outlined, label: salaryLabel),
              _InfoChip(icon: Icons.schedule_outlined, label: job.jobType),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(int amount) {
    if (amount >= 1000) {
      final k = amount ~/ 1000;
      return '${k}k';
    }
    return amount.toString();
  }
}

// ── Info chip ─────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: HireIQTheme.backgroundLight,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: HireIQTheme.textMuted),
          const SizedBox(width: 5),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textSecondary,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ── Tab item ──────────────────────────────────────────────────────────────────

class _TabItem extends StatelessWidget {
  const _TabItem({required this.label, this.isActive = false});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? HireIQTheme.primaryNavy : HireIQTheme.textMuted),
        ),
        const SizedBox(height: 6),
        Container(
          height: 2,
          width: 20,
          decoration: BoxDecoration(
            color: isActive ? HireIQTheme.primaryTeal : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}

// ── Apply bottom sheet ────────────────────────────────────────────────────────

class _ApplySheet extends StatelessWidget {
  const _ApplySheet({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            boxShadow: [
              BoxShadow(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Apply Now',
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
