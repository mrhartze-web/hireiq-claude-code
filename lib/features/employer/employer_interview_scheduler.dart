import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class EmployerInterviewScheduler extends ConsumerStatefulWidget {
  const EmployerInterviewScheduler({super.key});

  @override
  ConsumerState<EmployerInterviewScheduler> createState() =>
      _EmployerInterviewSchedulerState();
}

class _EmployerInterviewSchedulerState
    extends ConsumerState<EmployerInterviewScheduler>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  static const _upcoming = [
    _InterviewSlot(
      candidate: 'Thabo Nkosi',
      role: 'Senior Flutter Developer',
      date: 'Mon, 23 Mar 2026',
      time: '10:00 AM',
      type: 'Video',
      panelists: ['Sarah Botha', 'Ravi Pillay'],
    ),
    _InterviewSlot(
      candidate: 'Nomsa Dlamini',
      role: 'Senior Flutter Developer',
      date: 'Tue, 24 Mar 2026',
      time: '2:00 PM',
      type: 'In-person',
      panelists: ['Sarah Botha'],
    ),
  ];

  static const _pending = [
    _InterviewSlot(
      candidate: 'Craig Botha',
      role: 'Senior Flutter Developer',
      date: 'TBD',
      time: 'TBD',
      type: 'Video',
      panelists: [],
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
              'Interview Scheduler',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded,
                    size: 22, color: Colors.white),
                onPressed: () {},
              ),
            ],
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
                Tab(text: 'Upcoming (2)'),
                Tab(text: 'Pending (1)'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _buildList(_upcoming),
            _buildList(_pending, isPending: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: HireIQTheme.amber,
        foregroundColor: HireIQTheme.primaryNavy,
        icon: const Icon(Icons.add),
        label: Text(
          'Schedule',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildList(List<_InterviewSlot> slots,
      {bool isPending = false}) {
    if (slots.isEmpty) {
      return const EmptyState(
        icon: Icons.calendar_today_outlined,
        heading: 'No interviews scheduled',
        body: 'Schedule interviews from the candidate pipeline.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: slots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) =>
          _InterviewCard(slot: slots[i], isPending: isPending),
    );
  }
}

class _InterviewSlot {
  const _InterviewSlot({
    required this.candidate,
    required this.role,
    required this.date,
    required this.time,
    required this.type,
    required this.panelists,
  });

  final String candidate;
  final String role;
  final String date;
  final String time;
  final String type;
  final List<String> panelists;
}

class _InterviewCard extends StatelessWidget {
  const _InterviewCard({required this.slot, required this.isPending});

  final _InterviewSlot slot;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: isPending
                ? HireIQTheme.warning.withValues(alpha: 0.3)
                : HireIQTheme.borderLight),
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
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
                child: Text(
                  slot.candidate.split(' ').map((w) => w[0]).take(2).join(),
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slot.candidate,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    Text(
                      slot.role,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPending ? HireIQTheme.warning : HireIQTheme.primaryTeal)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  slot.type,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isPending ? HireIQTheme.warning : HireIQTheme.primaryTeal),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 13, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                isPending ? 'Awaiting time confirmation' : '${slot.date} at ${slot.time}',
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted),
              ),
            ],
          ),
          if (slot.panelists.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.people_outline_rounded,
                    size: 13, color: HireIQTheme.textMuted),
                const SizedBox(width: 5),
                Text(
                  slot.panelists.join(', '),
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isPending)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.amber,
                      foregroundColor: HireIQTheme.primaryNavy,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text(
                      'Schedule Now',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                )
              else ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: HireIQTheme.primaryNavy,
                      side: const BorderSide(color: HireIQTheme.borderMedium),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text(
                      'Join Call',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text(
                      'Reschedule',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
