import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/web_layout.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int _activeTab = 0;

  static const _tabs = [
    'All',
    'Hiring Trends',
    'AI and Technology',
    'B-BBEE and Compliance',
    'Career Development',
    'Salary Guides',
  ];

  static const _articles = [
    (
      title:
          "Why South Africa's Recruitment Industry is Ripe for Disruption",
      category: 'Hiring Trends',
      readTime: '5 min read',
      preview:
          'With a 32% unemployment rate and placement fees of 15–20% of annual salary, the traditional recruitment model is failing both employers and candidates. Here is what the data says about what comes next.',
    ),
    (
      title: 'MatchIQ vs Keyword Filtering — Why AI Matching Changes Everything',
      category: 'AI and Technology',
      readTime: '4 min read',
      preview:
          'Traditional ATS systems filter candidates by keywords. MatchIQ scores fit across 80 data points. The difference in placement quality is measurable.',
    ),
    (
      title: 'The True Cost of a Bad Hire in South Africa',
      category: 'Hiring Trends',
      readTime: '6 min read',
      preview:
          'A bad hire at R300,000 annual salary costs an employer an estimated R450,000 when you factor in recruitment fees, onboarding, productivity loss, and rehiring costs. Here is how to avoid it.',
    ),
    (
      title:
          'B-BBEE Compliance in Recruitment — What Every SA Employer Needs to Know in 2026',
      category: 'B-BBEE and Compliance',
      readTime: '7 min read',
      preview:
          'B-BBEE scorecard compliance affects procurement, financing, and partnerships. HireIQ\'s WildcardIQ and diversity reporting make compliance measurable and achievable.',
    ),
  ];

  List<
      ({
        String title,
        String category,
        String readTime,
        String preview
      })> get _filtered {
    if (_activeTab == 0) return _articles;
    final tab = _tabs[_activeTab];
    return _articles.where((a) => a.category == tab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(),
          _FilterTabs(
            tabs: _tabs,
            activeIndex: _activeTab,
            onTap: (i) => setState(() => _activeTab = i),
          ),
          _ArticlesGrid(articles: _filtered),
          _NewsletterSection(),
        ],
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            children: [
              Text(
                'Resources and Insights',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Stay ahead with the latest thinking on AI recruitment, talent acquisition, and employment trends in South Africa.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.65,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Filter tabs ───────────────────────────────────────────────────────────────

class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.tabs,
    required this.activeIndex,
    required this.onTap,
  });

  final List<String> tabs;
  final int activeIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isActive = i == activeIndex;
            return GestureDetector(
              onTap: () => onTap(i),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  margin: EdgeInsets.only(right: i < tabs.length - 1 ? 4 : 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive
                            ? HireIQTheme.primaryTeal
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                  child: Text(
                    tabs[i],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: isActive
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: isActive
                          ? HireIQTheme.primaryNavy
                          : HireIQTheme.textMuted,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ── Articles grid ─────────────────────────────────────────────────────────────

class _ArticlesGrid extends StatelessWidget {
  const _ArticlesGrid({required this.articles});

  final List<
      ({
        String title,
        String category,
        String readTime,
        String preview
      })> articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 72),
      child: articles.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'No articles in this category yet.',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 15),
                ),
              ),
            )
          : LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              if (isWide) {
                final rows = <Widget>[];
                for (var i = 0; i < articles.length; i += 2) {
                  final hasRight = i + 1 < articles.length;
                  rows.add(Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _ArticleCard(article: articles[i])),
                      const SizedBox(width: 24),
                      hasRight
                          ? Expanded(
                              child: _ArticleCard(
                                  article: articles[i + 1]))
                          : const Expanded(child: SizedBox()),
                    ],
                  ));
                  if (i + 2 < articles.length) {
                    rows.add(const SizedBox(height: 24));
                  }
                }
                return Column(children: rows);
              }
              return Column(
                children: articles
                    .map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _ArticleCard(article: a),
                        ))
                    .toList(),
              );
            }),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final ({
    String title,
    String category,
    String readTime,
    String preview
  }) article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Text(
                article.category,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.schedule_outlined,
                size: 13, color: HireIQTheme.textMuted),
            const SizedBox(width: 4),
            Text(article.readTime,
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted)),
          ]),
          const SizedBox(height: 14),
          Text(
            article.title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              height: 1.35,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            article.preview,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Full articles coming soon — subscribe for updates'),
                backgroundColor: HireIQTheme.primaryNavy,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQTheme.primaryTeal,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull)),
            ),
            child: Text('Read Article',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// ── Newsletter ────────────────────────────────────────────────────────────────

class _NewsletterSection extends StatefulWidget {
  @override
  State<_NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<_NewsletterSection> {
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _subscribe() {
    if (_emailCtrl.text.trim().isEmpty || !_emailCtrl.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email address')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'You are subscribed — we will send updates to your inbox'),
        backgroundColor: HireIQTheme.primaryTeal,
      ),
    );
    _emailCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            children: [
              Text(
                'Stay informed. Stay competitive.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Get the latest HireIQ insights delivered to your inbox.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 32),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      hintStyle: GoogleFonts.inter(
                          color: HireIQTheme.textMuted, fontSize: 14),
                      filled: true,
                      fillColor: HireIQTheme.surfaceWhite,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull),
                        borderSide: const BorderSide(
                            color: HireIQTheme.amber, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _subscribe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.amber,
                    foregroundColor: HireIQTheme.primaryNavy,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull)),
                  ),
                  child: Text('Subscribe',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
