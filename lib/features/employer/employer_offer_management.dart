import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class EmployerOfferManagement extends ConsumerStatefulWidget {
  const EmployerOfferManagement({super.key});

  @override
  ConsumerState<EmployerOfferManagement> createState() =>
      _EmployerOfferManagementState();
}

class _EmployerOfferManagementState
    extends ConsumerState<EmployerOfferManagement>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  static const _offers = [
    _Offer(
      candidate: 'Ayanda Khumalo',
      role: 'Senior Flutter Developer',
      salary: 'R720,000',
      sentDate: '20 Mar 2026',
      status: 'Pending',
    ),
    _Offer(
      candidate: 'Sipho van Rooyen',
      role: 'Senior Flutter Developer',
      salary: 'R696,000',
      sentDate: '18 Mar 2026',
      status: 'Accepted',
    ),
  ];

  static const _rejected = [
    _Offer(
      candidate: 'Zanele Mokoena',
      role: 'Data Scientist',
      salary: 'R600,000',
      sentDate: '10 Mar 2026',
      status: 'Declined',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Offer Management',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            bottom: TabBar(
              controller: _tabs,
              labelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w500),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
              indicatorColor: HireIQTheme.amber,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Closed'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _buildList(_offers),
            _buildList(_rejected),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<_Offer> offers) {
    if (offers.isEmpty) {
      return const EmptyState(
        icon: Icons.handshake_outlined,
        heading: 'No offers here',
        body: 'Offers sent to candidates will appear in this view.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _OfferCard(offer: offers[i]),
    );
  }
}

class _Offer {
  const _Offer({
    required this.candidate,
    required this.role,
    required this.salary,
    required this.sentDate,
    required this.status,
  });

  final String candidate;
  final String role;
  final String salary;
  final String sentDate;
  final String status;
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer});
  final _Offer offer;

  Color get _statusColor {
    switch (offer.status) {
      case 'Accepted':
        return HireIQTheme.success;
      case 'Declined':
        return HireIQTheme.error;
      case 'Pending':
        return HireIQTheme.warning;
      default:
        return HireIQTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(
                  offer.candidate
                      .split(' ')
                      .map((w) => w[0])
                      .take(2)
                      .join(),
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryTeal),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.candidate,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    Text(
                      offer.role,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  offer.status,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _statusColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.payments_outlined,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 6),
              Text(
                offer.salary,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy),
              ),
              const Spacer(),
              Text(
                'Sent ${offer.sentDate}',
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted),
              ),
            ],
          ),
          if (offer.status == 'Pending') ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: HireIQTheme.error,
                      side: const BorderSide(color: HireIQTheme.error),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text(
                      'Withdraw',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text(
                      'Follow Up',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
