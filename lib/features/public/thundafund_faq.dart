import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class ThundafundFaq extends StatelessWidget {
  const ThundafundFaq({super.key});

  static const List<_FaqItem> _faqs = [
    _FaqItem(
      q: 'What is Thundafund and how does it work?',
      a: 'Thundafund is South Africa\'s leading rewards-based crowdfunding platform. You pledge an amount, receive a reward tier, and help us hit our funding goal. If the goal is not reached by the deadline, no charges are made.',
    ),
    _FaqItem(
      q: 'When will I receive my backer rewards?',
      a: 'Digital rewards (Pro access, badges, newsletter) are delivered within 7 days of a successful campaign close. Physical rewards and access to advisory calls are scheduled within 60 days.',
    ),
    _FaqItem(
      q: 'Is my payment secure?',
      a: 'All payments are processed by Thundafund via PCI-DSS compliant payment gateways. HireIQ does not store your payment details.',
    ),
    _FaqItem(
      q: 'Can I upgrade my pledge tier later?',
      a: 'Yes — you can increase your pledge at any time before the campaign closes. Contact support@hireiq.co.za and we will adjust your tier manually.',
    ),
    _FaqItem(
      q: 'What happens if the goal is exceeded?',
      a: 'Stretch goals unlock additional features: 125% funds a mobile offline mode; 150% funds an expanded SignalIQ salary dataset covering all nine provinces.',
    ),
    _FaqItem(
      q: 'Will HireIQ remain free for candidates?',
      a: 'Yes. The core job-search and application experience will always be free for candidates. Premium features (ForgeIQ CV builder, UpliftIQ courses) will have optional paid tiers.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Everything you need to know before backing HireIQ.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ..._faqs.map((faq) => _buildFaqCard(faq)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mail_outline,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Still have questions? Email us at hello@hireiq.co.za',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard(_FaqItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.question_mark,
                    color: HireIQTheme.primaryTeal, size: 12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  faq.q,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Text(
              faq.a,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  const _FaqItem({required this.q, required this.a});
  final String q;
  final String a;
}
