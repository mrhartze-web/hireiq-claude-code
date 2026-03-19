import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigProposalsViewScreen extends ConsumerStatefulWidget {
  const GigProposalsViewScreen({super.key});

  @override
  ConsumerState<GigProposalsViewScreen> createState() =>
      _GigProposalsViewScreenState();
}

class _GigProposalsViewScreenState
    extends ConsumerState<GigProposalsViewScreen> {
  int _tabIndex = 0;
  String _sortValue = 'Best match';

  static const List<_TabData> _tabs = [
    _TabData(label: 'All', count: 10),
    _TabData(label: 'New', count: 4),
    _TabData(label: 'Shortlisted', count: 3),
    _TabData(label: 'Declined', count: 3),
  ];

  static const List<_ProposalData> _proposals = [
    _ProposalData(
      initials: 'TN',
      name: 'Thabo Nkosi',
      headline: 'Senior Flutter Developer',
      rate: 'R850/hr',
      delivery: '14 days',
      matchScore: '94%',
      statusLabel: 'New',
      coverNote:
          'I have extensive experience building Flutter apps for fintech clients...',
      avatarColor: HireIQTheme.primaryTeal,
    ),
    _ProposalData(
      initials: 'AM',
      name: 'Amara Mensah',
      headline: 'Full-Stack Engineer',
      rate: 'R720/hr',
      delivery: '21 days',
      matchScore: '87%',
      statusLabel: 'New',
      coverNote:
          'Your project aligns perfectly with my API integration background...',
      avatarColor: HireIQTheme.recruiterAccent,
    ),
    _ProposalData(
      initials: 'KP',
      name: 'Kavya Patel',
      headline: 'Mobile Developer',
      rate: 'R680/hr',
      delivery: '18 days',
      matchScore: '81%',
      statusLabel: 'Shortlisted',
      coverNote:
          'I specialize in Flutter and have delivered 12 similar projects...',
      avatarColor: HireIQTheme.primaryNavy,
    ),
    _ProposalData(
      initials: 'LV',
      name: 'Liam van Rensburg',
      headline: 'React Native Dev',
      rate: 'R600/hr',
      delivery: '25 days',
      matchScore: '74%',
      statusLabel: 'New',
      coverNote:
          'While my background is React Native, I am actively learning Flutter...',
      avatarColor: HireIQTheme.amber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: HireIQTheme.primaryNavy),
        title: Text(
          'Gig Proposals',
          style: GoogleFonts.inter(
            color: HireIQTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab row
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: HireIQTheme.borderLight),
              ),
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isActive = _tabIndex == i;
                return GestureDetector(
                  onTap: () => setState(() => _tabIndex = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: isActive
                          ? const Border(
                              bottom: BorderSide(
                                color: HireIQTheme.primaryTeal,
                                width: 2,
                              ),
                            )
                          : null,
                    ),
                    child: Text(
                      '${tab.label} (${tab.count})',
                      style: GoogleFonts.inter(
                        color: isActive
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Sort row
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Sort by:',
                  style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _sortValue,
                  underline: const SizedBox.shrink(),
                  style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted,
                    fontSize: 12,
                  ),
                  items: ['Best match', 'Lowest rate', 'Fastest delivery']
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _sortValue = value ?? 'Best match';
                    });
                  },
                ),
              ],
            ),
          ),

          // Proposals list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _proposals.length,
              itemBuilder: (context, index) {
                final proposal = _proposals[index];
                return _ProposalCard(proposal: proposal);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabData {
  final String label;
  final int count;
  const _TabData({required this.label, required this.count});
}

class _ProposalData {
  final String initials;
  final String name;
  final String headline;
  final String rate;
  final String delivery;
  final String matchScore;
  final String statusLabel;
  final String coverNote;
  final Color avatarColor;

  const _ProposalData({
    required this.initials,
    required this.name,
    required this.headline,
    required this.rate,
    required this.delivery,
    required this.matchScore,
    required this.statusLabel,
    required this.coverNote,
    required this.avatarColor,
  });
}

class _ProposalCard extends StatelessWidget {
  final _ProposalData proposal;
  const _ProposalCard({required this.proposal});

  Color get _statusBg {
    switch (proposal.statusLabel) {
      case 'Shortlisted':
        return HireIQTheme.success.withValues(alpha: 0.1);
      case 'Declined':
        return HireIQTheme.error.withValues(alpha: 0.1);
      default:
        return HireIQTheme.primaryTeal.withValues(alpha: 0.1);
    }
  }

  Color get _statusColor {
    switch (proposal.statusLabel) {
      case 'Shortlisted':
        return HireIQTheme.success;
      case 'Declined':
        return HireIQTheme.error;
      default:
        return HireIQTheme.primaryTeal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: proposal.avatarColor,
                child: Text(
                  proposal.initials,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.name,
                      style: GoogleFonts.inter(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      proposal.headline,
                      style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  'MatchIQ ${proposal.matchScore}',
                  style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Rate / delivery / status row
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    proposal.rate,
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    proposal.delivery,
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusBg,
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  proposal.statusLabel,
                  style: GoogleFonts.inter(
                    color: _statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            proposal.coverNote,
            style: GoogleFonts.inter(
              color: HireIQTheme.textMuted,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: HireIQTheme.primaryNavy),
                    foregroundColor: HireIQTheme.primaryNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                  ),
                  child: Text(
                    'View Profile',
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to shortlist'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.amber,
                    foregroundColor: HireIQTheme.primaryNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Shortlist',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
