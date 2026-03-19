import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/recruiter_provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

// ── Data model ────────────────────────────────────────────────────────────────

class _PlacementRow {
  const _PlacementRow({
    required this.role,
    required this.annualSalary,
    required this.feePercent,
    required this.totalFee,
    this.isPending = false,
  });

  final String role;
  final String annualSalary;
  final double feePercent;   // e.g. 0.10
  final double totalFee;     // e.g. 20000
  final bool isPending;

  double get hireiqCut => totalFee * hireiqPlatformCutPercent;
  double get yourEarnings => totalFee * (1 - hireiqPlatformCutPercent);

  String get feePercentLabel =>
      '${(feePercent * 100).toStringAsFixed(0)}%';
  String get totalFeeLabel => _rands(totalFee);
  String get hireiqCutLabel => _rands(hireiqCut);
  String get yourEarningsLabel => _rands(yourEarnings);

  static String _rands(double v) {
    final s = v.toInt().toString();
    final buf = StringBuffer('R');
    final rem = s.length % 3;
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (i - rem) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

// ── Screen ────────────────────────────────────────────────────────────────────

class RecruiterEarningsDashboard extends ConsumerWidget {
  const RecruiterEarningsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) {
      return const Center(child: Text('Not Authenticated'));
    }
    final placementsAsync = ref.watch(recruiterPlacementsProvider(user.uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Earnings',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.date_range, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: placementsAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: SkeletonLoader(itemCount: 3),
        ),
        error: (_, __) => const Center(child: Text('Could not load earnings')),
        data: (placements) {
          final rows = placements.map((p) => _PlacementRow(
            role: p.roleName,
            annualSalary: _PlacementRow._rands(p.annualSalary.toDouble()),
            feePercent: p.feePercentage / 100,
            totalFee: p.feeAmount,
            isPending: p.paymentStatus != 'paid',
          )).toList();

          if (rows.isEmpty) {
            return const EmptyState(
              icon: Icons.account_balance_wallet_outlined,
              heading: 'No placements yet',
              body: 'Your earnings will appear here once you record a placement',
            );
          }

          final totalEarnings = rows
              .where((r) => !r.isPending)
              .fold(0.0, (sum, r) => sum + r.yourEarnings);
          final pendingEarnings = rows
              .where((r) => r.isPending)
              .fold(0.0, (sum, r) => sum + r.yourEarnings);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Summary hero card ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                    boxShadow: [
                      BoxShadow(
                        color: HireIQTheme.primaryNavy.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Earnings (YTD)',
                        style: GoogleFonts.inter(
                            color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _PlacementRow._rands(totalEarnings),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _HeroStat(
                            label: 'Pending Payouts',
                            value: _PlacementRow._rands(pendingEarnings),
                            valueColor: HireIQTheme.primaryTeal,
                          ),
                          _HeroStat(
                            label: 'Active Placements',
                            value: '${rows.length}',
                            valueColor: Colors.white,
                          ),
                          _HeroStat(
                            label: 'Platform Cut (${(hireiqPlatformCutPercent * 100).toStringAsFixed(0)}%)',
                            value: _PlacementRow._rands(
                              rows.fold(0.0, (s, r) => s + r.hireiqCut),
                            ),
                            valueColor: Colors.white60,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── Section label ──────────────────────────────────────────────
                Text(
                  'Placement Breakdown',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 4),
                Text(
                  'HireIQ retains ${(hireiqPlatformCutPercent * 100).toStringAsFixed(0)}% of each placement fee. '
                  'Your earnings are the remaining ${((1 - hireiqPlatformCutPercent) * 100).toStringAsFixed(0)}%.',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: HireIQTheme.textMuted, height: 1.5),
                ),

                const SizedBox(height: 16),

                // ── Placement cards ────────────────────────────────────────────
                ...rows.map((row) => _PlacementCard(row: row)),

                const SizedBox(height: 8),

                // ── VAT note ──────────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          size: 15, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'All amounts are exclusive of VAT (15%). '
                          'Payouts are processed within 5 business days of the guarantee period ending. '
                          'Contact $supportEmail for queries.',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: HireIQTheme.primaryTeal,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Hero stat widget ──────────────────────────────────────────────────────────

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.inter(
                color: valueColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ── Placement card (6-column breakdown) ───────────────────────────────────────

class _PlacementCard extends StatelessWidget {
  const _PlacementCard({required this.row});

  final _PlacementRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Role + status badge ────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Text(
                  row.role,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
              if (row.isPending)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: HireIQTheme.amber.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Pending',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.amber,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Row 1: Annual Salary | Fee % | Total Fee ───────────────────
          Row(
            children: [
              Expanded(
                  child: _Col(label: 'Annual Salary',
                      value: row.annualSalary)),
              Expanded(
                  child: _Col(label: 'Fee Percentage',
                      value: row.feePercentLabel)),
              Expanded(
                  child: _Col(label: 'Total Fee',
                      value: row.totalFeeLabel)),
            ],
          ),

          const SizedBox(height: 12),

          // ── Divider ────────────────────────────────────────────────────
          Container(height: 1, color: HireIQTheme.borderLight),

          const SizedBox(height: 12),

          // ── Row 2: HireIQ Cut | Your Earnings ─────────────────────────
          Row(
            children: [
              Expanded(
                child: _Col(
                  label: 'HireIQ Cut (${(hireiqPlatformCutPercent * 100).toStringAsFixed(0)}%)',
                  value: row.hireiqCutLabel,
                  valueColor: HireIQTheme.textMuted,
                ),
              ),
              Expanded(
                child: _Col(
                  label: 'Your Earnings',
                  value: row.yourEarningsLabel,
                  valueColor: HireIQTheme.primaryTeal,
                  isBold: true,
                ),
              ),
              // Spacer to match 3-column grid above
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Column cell ───────────────────────────────────────────────────────────────

class _Col extends StatelessWidget {
  const _Col({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? HireIQTheme.primaryNavy,
          ),
        ),
      ],
    );
  }
}
