import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/skeleton_loader.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

class CandidateSalaryGuide extends ConsumerStatefulWidget {
  const CandidateSalaryGuide({super.key});

  @override
  ConsumerState<CandidateSalaryGuide> createState() =>
      _CandidateSalaryGuideState();
}

class _CandidateSalaryGuideState extends ConsumerState<CandidateSalaryGuide> {
  String _selectedRole = 'Software Engineer';
  String _selectedLocation = 'Johannesburg';
  String _selectedExp = 'Mid-level (3–5 yrs)';

  static const _roles = [
    'Software Engineer',
    'Product Manager',
    'Data Scientist',
    'UX Designer',
    'DevOps Engineer',
  ];

  static const _locations = [
    'Johannesburg',
    'Cape Town',
    'Durban',
    'Pretoria',
    'Remote',
  ];

  static const _expLevels = [
    'Junior (0–2 yrs)',
    'Mid-level (3–5 yrs)',
    'Senior (5–8 yrs)',
    'Lead / Principal (8+ yrs)',
  ];

  static const _bands = [
    _SalaryBand(
      level: 'Junior (0–2 yrs)',
      min: 280000,
      max: 420000,
      barFraction: 0.35,
      isYou: false,
    ),
    _SalaryBand(
      level: 'Mid-level (3–5 yrs)',
      min: 450000,
      max: 700000,
      barFraction: 0.58,
      isYou: true,
    ),
    _SalaryBand(
      level: 'Senior (5–8 yrs)',
      min: 720000,
      max: 980000,
      barFraction: 0.80,
      isYou: false,
    ),
    _SalaryBand(
      level: 'Lead / Principal (8+ yrs)',
      min: 1000000,
      max: 1500000,
      barFraction: 1.0,
      isYou: false,
    ),
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Salary Guide',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline_rounded,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: _isLoading
                  ? const SkeletonLoader(itemCount: 5)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── SignalIQ Header ───────────────────────────────
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryTeal
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.insights_rounded,
                                  size: 16, color: HireIQTheme.primaryTeal),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Powered by SignalIQ™',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: HireIQTheme.primaryTeal,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Updated Mar 2026',
                              style: GoogleFonts.inter(
                                  fontSize: 11, color: HireIQTheme.textMuted),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── Your Market Value Card ────────────────────────
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryNavy,
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusXl),
                            boxShadow: [
                              BoxShadow(
                                color: HireIQTheme.primaryNavy
                                    .withValues(alpha: 0.25),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Market Value',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color:
                                      Colors.white.withValues(alpha: 0.65),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'R450,000 – R700,000',
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: HireIQTheme.success
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(
                                          HireIQTheme.radiusFull),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.trending_up_rounded,
                                            size: 12,
                                            color: HireIQTheme.success),
                                        const SizedBox(width: 4),
                                        Text(
                                          '+8.3% YoY',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: HireIQTheme.success,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'vs last year',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color:
                                          Colors.white.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 1,
                                color:
                                    Colors.white.withValues(alpha: 0.1),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildStatChip(
                                      'Software Engineer', Icons.code_rounded),
                                  const SizedBox(width: 8),
                                  _buildStatChip(
                                      'Johannesburg', Icons.location_on_rounded),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Filters ───────────────────────────────────────
                        Text(
                          'Filter Results',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown('Role', _roles, _selectedRole,
                            (v) => setState(() => _selectedRole = v!)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                  'Location',
                                  _locations,
                                  _selectedLocation,
                                  (v) => setState(
                                      () => _selectedLocation = v!)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildDropdown(
                                  'Experience',
                                  _expLevels,
                                  _selectedExp,
                                  (v) =>
                                      setState(() => _selectedExp = v!)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // ── Salary Bands Chart ────────────────────────────
                        Text(
                          'Salary Bands by Experience',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ..._bands.map((b) => _SalaryBandBar(band: b)),
                        const SizedBox(height: 28),

                        // ── Negotiation Tip ───────────────────────────────
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: HireIQTheme.amber.withValues(alpha: 0.08),
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusLg),
                            border: Border.all(
                              color:
                                  HireIQTheme.amber.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.lightbulb_outline_rounded,
                                  color: HireIQTheme.amber, size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Negotiation Tip',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: HireIQTheme.primaryNavy,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Always wait for the employer to state their budget first. Use your MatchIQ score and Wildcard skills as leverage to negotiate to the upper end of your band.',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: HireIQTheme.textMuted,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.7)),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> options,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textMuted),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          style: GoogleFonts.inter(
              fontSize: 13, color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: HireIQTheme.surfaceWhite,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(
                  color: HireIQTheme.primaryTeal, width: 1.5),
            ),
          ),
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textPrimary, fontSize: 13),
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ── Salary Band Model ─────────────────────────────────────────────────────────

class _SalaryBand {
  const _SalaryBand({
    required this.level,
    required this.min,
    required this.max,
    required this.barFraction,
    required this.isYou,
  });

  final String level;
  final int min;
  final int max;
  final double barFraction;
  final bool isYou;
}

// ── Salary Band Bar ───────────────────────────────────────────────────────────

class _SalaryBandBar extends StatelessWidget {
  const _SalaryBandBar({required this.band});
  final _SalaryBand band;

  String _fmt(int n) {
    if (n >= 1000000) return 'R${(n / 1000000).toStringAsFixed(1)}m';
    return 'R${(n / 1000).toStringAsFixed(0)}k';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: band.isYou
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.4)
              : HireIQTheme.borderLight,
          width: band.isYou ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    band.level,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary,
                    ),
                  ),
                  if (band.isYou) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                      ),
                      child: Text(
                        'You',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '${_fmt(band.min)} – ${_fmt(band.max)}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: band.isYou
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.primaryNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: HireIQTheme.borderLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: constraints.maxWidth * band.barFraction,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: band.isYou
                            ? [
                                HireIQTheme.primaryTeal,
                                const Color(0xFF0B7A70),
                              ]
                            : [
                                HireIQTheme.primaryNavy.withValues(alpha: 0.4),
                                HireIQTheme.primaryNavy.withValues(alpha: 0.6),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
