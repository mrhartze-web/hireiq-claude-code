import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateUpliftIqWeb extends ConsumerStatefulWidget {
  const CandidateUpliftIqWeb({super.key});
  @override
  ConsumerState<CandidateUpliftIqWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateUpliftIqWeb>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  static const _labels = ['Recommendations', 'Courses', 'Resources'];

  static const _recs = [
    _URec('📚', 'Flutter Advanced Architecture', 'Coursera', 'Skill Gap: Missing BLoC pattern experience', HireIQTheme.primary),
    _URec('✍️', 'Add 2 Portfolio Projects', 'ForgeIQ', 'Profile Gap: Employers want to see real work', HireIQTheme.warning),
    _URec('🎯', 'Apply to 5 targeted roles this week', 'SmartApply', 'Activity: Low application volume this month', HireIQTheme.info),
    _URec('💼', 'Practice system design interviews', 'Interview Prep', 'Interview Gap: Senior role readiness', HireIQTheme.recruiterAccent),
    _URec('✅', 'Complete PassportIQ verification', 'PassportIQ', 'Trust Gap: Unverified profiles get 40% fewer responses', HireIQTheme.success),
  ];

  static const _courses = [
    _UCourse('Flutter & Dart — Complete Course', 'Udemy', '40h', 'R499', 4.8, HireIQTheme.primaryTeal),
    _UCourse('System Design for Mobile Apps', 'Coursera', '20h', 'Free', 4.6, HireIQTheme.info),
    _UCourse('Firebase for Flutter', 'YouTube', '8h', 'Free', 4.4, HireIQTheme.error),
    _UCourse('BLoC Pattern Masterclass', 'Udemy', '12h', 'R299', 4.7, HireIQTheme.primaryNavy),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _labels.length, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.recruiterAccent, size: 26),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('UpliftIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Your personalised AI career coach', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
          ]),
          const SizedBox(height: 24),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: tabs
            Expanded(flex: 2, child: Column(children: [
              TabBar(controller: _tab, labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13), unselectedLabelStyle: GoogleFonts.inter(fontSize: 13), labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted, indicatorColor: HireIQTheme.recruiterAccent, tabs: _labels.map((l) => Tab(text: l)).toList()),
              const SizedBox(height: 14),
              SizedBox(height: 580, child: TabBarView(controller: _tab, children: [
                // Recommendations tab
                ListView(children: _recs.map((r) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                  child: Row(children: [
                    Text(r.emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      const SizedBox(height: 2),
                      Text(r.rationale, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted, height: 1.4)),
                      const SizedBox(height: 6),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: r.tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(r.source, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: r.tagColor))),
                    ])),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Start', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700))),
                  ]),
                )).toList()),
                // Courses tab
                ListView(children: _courses.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                  child: Row(children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: c.tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Icon(Icons.play_circle_rounded, color: c.tagColor, size: 24))),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(c.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      Text('${c.provider} · ${c.duration}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.star_rounded, size: 12, color: HireIQTheme.amber), const SizedBox(width: 2), Text('${c.rating}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted))]),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(c.price, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: c.price == 'Free' ? HireIQTheme.success : HireIQTheme.primaryNavy)),
                      TextButton(onPressed: () {}, child: Text('Enrol', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                    ]),
                  ]),
                )).toList()),
                // Resources tab
                Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.article_rounded, size: 48, color: HireIQTheme.borderMedium), const SizedBox(height: 12), Text('Resources coming soon', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)), Text('Interview guides, templates and books will be available here.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textLight), textAlign: TextAlign.center)])),
              ])),
            ])),
            const SizedBox(width: 24),
            // Right: career readiness
            SizedBox(width: 300, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(gradient: LinearGradient(colors: [HireIQTheme.recruiterAccent, HireIQTheme.recruiterAccent.withValues(alpha: 0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Career Readiness', style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
                  Text('72%', style: GoogleFonts.inter(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white)),
                  ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: const LinearProgressIndicator(value: 0.72, minHeight: 10, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
                  const SizedBox(height: 14),
                  Text('Complete 3 more items to reach 100% readiness.', style: GoogleFonts.inter(fontSize: 12, color: Colors.white70, height: 1.4)),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('AI Progress Update', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 12),
                  ...[
                    ('Skills', '78%', HireIQTheme.primaryTeal),
                    ('Experience', '90%', HireIQTheme.success),
                    ('Portfolio', '40%', HireIQTheme.warning),
                    ('Verification', '50%', HireIQTheme.info),
                  ].map((s) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [Text(s.$1, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)), const Spacer(), Text(s.$2, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: s.$3))]),
                    const SizedBox(height: 4),
                    ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: double.parse(s.$2.replaceAll('%', '')) / 100, minHeight: 7, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(s.$3))),
                  ]))),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _URec {
  const _URec(this.emoji, this.title, this.source, this.rationale, this.tagColor);
  final String emoji, title, source, rationale;
  final Color tagColor;
}

class _UCourse {
  const _UCourse(this.title, this.provider, this.duration, this.price, this.rating, this.tagColor);
  final String title, provider, duration, price;
  final double rating;
  final Color tagColor;
}

const _primary = HireIQTheme.primaryTeal;
