import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class ThundafundSocialProof extends StatelessWidget {
  const ThundafundSocialProof({super.key});

  static const List<_Testimonial> _testimonials = [
    _Testimonial(
      name: 'Lerato Mokoena',
      role: 'Senior Software Engineer',
      body:
          'I backed HireIQ at the Champion tier. Within two weeks of early access I had three interview invitations — more in a fortnight than I had in six months on other platforms.',
      initials: 'LM',
    ),
    _Testimonial(
      name: 'James van der Berg',
      role: 'Head of Talent — FinServ Now',
      body:
          'WildcardIQ changed how we shortlist. We saw a 38% increase in diversity of first-round candidates without compromising quality. The ROI alone justified our Patron pledge.',
      initials: 'JV',
    ),
    _Testimonial(
      name: 'Aisha Patel',
      role: 'Recruitment Consultant',
      body:
          'The brief builder and CV vault save me hours every week. Backing HireIQ was an easy decision — this is the tool the South African market has been waiting for.',
      initials: 'AP',
    ),
  ];

  static const List<_Stat> _stats = [
    _Stat(value: '284', label: 'Backers'),
    _Stat(value: '12', label: 'Hiring partners'),
    _Stat(value: '94%', label: 'Backer satisfaction'),
    _Stat(value: 'R142k', label: 'Raised so far'),
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
              'What Backers Say',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real feedback from the people already using HireIQ.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            // Stats row
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _stats
                    .map(
                      (s) => Column(
                        children: [
                          Text(
                            s.value,
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.label,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            ..._testimonials.map((t) => _buildTestimonial(t)),

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
                  const Icon(Icons.construction_outlined,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'More backer stories and verified reviews coming soon.',
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

  Widget _buildTestimonial(_Testimonial t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
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
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                child: Text(
                  t.initials,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  Text(
                    t.role,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '"${t.body}"',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _Testimonial {
  const _Testimonial({
    required this.name,
    required this.role,
    required this.body,
    required this.initials,
  });
  final String name;
  final String role;
  final String body;
  final String initials;
}

class _Stat {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
}
