import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

class CandidateInterviewPrep extends ConsumerWidget {
  const CandidateInterviewPrep({super.key});

  static const _interviews = [
    _Interview(
      role: 'Senior Software Engineer',
      company: 'Apex Digital',
      date: 'Mon, 23 Mar 2026',
      time: '10:00 AM',
      type: 'Video',
      prepStatus: 'Ready',
    ),
    _Interview(
      role: 'Tech Lead',
      company: 'DataScale Africa',
      date: 'Wed, 25 Mar 2026',
      time: '2:00 PM',
      type: 'In-person',
      prepStatus: 'Needs Prep',
    ),
  ];

  static const _questions = [
    'Tell me about yourself and your background',
    'Describe a challenging technical problem you solved',
    'How do you handle disagreements with your team?',
    'What is your approach to code reviews?',
    'Where do you see yourself in 3 years?',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Interview Prep',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Upcoming Interviews ───────────────────────────────────
                Text(
                  'Upcoming Interviews',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                if (_interviews.isEmpty)
                  const EmptyState(
                    icon: Icons.calendar_today_outlined,
                    heading: 'No interviews scheduled',
                    body: 'When employers schedule interviews, they\'ll appear here.',
                  )
                else
                  ..._interviews.map((i) => _InterviewCard(interview: i)),
                const SizedBox(height: 24),

                // ── Video Pitch Reminder ──────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HireIQTheme.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(
                        color: HireIQTheme.amber.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.videocam_rounded,
                            color: HireIQTheme.amber, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Record your video pitch',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryNavy),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'A 60-second video pitch gets 3x more employer views',
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: HireIQTheme.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: HireIQTheme.amber,
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            'Record',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Common Questions ──────────────────────────────────────
                Text(
                  'Common Interview Questions',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 4),
                Text(
                  'Practice these with AI-powered feedback',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
                const SizedBox(height: 12),
                ..._questions.asMap().entries.map((e) =>
                    _QuestionTile(number: e.key + 1, question: e.value)),
                const SizedBox(height: 24),

                // ── UpliftIQ Tips ─────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.rocket_launch_rounded,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'UpliftIQ Interview Tips',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...[
                        '💡 Research the company\'s recent news and product releases',
                        '💡 Prepare 3 stories using the STAR method',
                        '💡 Have 5 thoughtful questions ready to ask the interviewer',
                        '💡 Test your tech 30 mins before any video call',
                      ].map((tip) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              tip,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color:
                                      Colors.white.withValues(alpha: 0.85),
                                  height: 1.5),
                            ),
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Interview {
  const _Interview({
    required this.role,
    required this.company,
    required this.date,
    required this.time,
    required this.type,
    required this.prepStatus,
  });

  final String role;
  final String company;
  final String date;
  final String time;
  final String type;
  final String prepStatus;
}

class _InterviewCard extends StatelessWidget {
  const _InterviewCard({required this.interview});
  final _Interview interview;

  @override
  Widget build(BuildContext context) {
    final ready = interview.prepStatus == 'Ready';
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interview.role,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      interview.company,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (ready ? HireIQTheme.success : HireIQTheme.warning)
                      .withValues(alpha: 0.12),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  interview.prepStatus,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: ready ? HireIQTheme.success : HireIQTheme.warning),
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
                '${interview.date} at ${interview.time}',
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  interview.type,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.amber,
                foregroundColor: HireIQTheme.primaryNavy,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd)),
              ),
              child: Text(
                'Start Preparation',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionTile extends StatefulWidget {
  const _QuestionTile({required this.number, required this.question});
  final int number;
  final String question;

  @override
  State<_QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<_QuestionTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: ListTile(
        onTap: () => setState(() => _expanded = !_expanded),
        leading: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${widget.number}',
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy),
            ),
          ),
        ),
        title: Text(
          widget.question,
          style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.textPrimary),
        ),
        trailing: Icon(
          _expanded ? Icons.expand_less : Icons.expand_more,
          color: HireIQTheme.textMuted,
        ),
        subtitle: _expanded
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.primaryTeal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusSm)),
                  ),
                  child: Text(
                    'Practice with AI',
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
