import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerConfirmHireScreen extends ConsumerStatefulWidget {
  const EmployerConfirmHireScreen({super.key});

  @override
  ConsumerState<EmployerConfirmHireScreen> createState() =>
      _EmployerConfirmHireScreenState();
}

class _EmployerConfirmHireScreenState
    extends ConsumerState<EmployerConfirmHireScreen> {
  bool _agreeShieldiq = false;
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Confirm Hire',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Candidate Summary Card ────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.3),
                    child: Text(
                      'AK',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ayanda Khumalo',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Senior Flutter Developer',
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.7)),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 12,
                                color: Color.fromRGBO(255, 255, 255, 0.6)),
                            const SizedBox(width: 3),
                            Text(
                              'Johannesburg, SA',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color:
                                      Colors.white.withValues(alpha: 0.6)),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: HireIQTheme.success
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                              ),
                              child: Text(
                                'PassportIQ Verified',
                                style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.success),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Offer Details ─────────────────────────────────────────────
            Text(
              'Offer Summary',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 12),
            Container(
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
                  _OfferRow('Position', 'Senior Flutter Developer'),
                  const Divider(height: 20, color: HireIQTheme.borderLight),
                  _OfferRow('Annual Salary', 'R720,000 (R60,000/month)'),
                  const Divider(height: 20, color: HireIQTheme.borderLight),
                  _OfferRow('Start Date', '01 April 2026'),
                  const Divider(height: 20, color: HireIQTheme.borderLight),
                  _OfferRow('Contract Type', 'Permanent'),
                  const Divider(height: 20, color: HireIQTheme.borderLight),
                  _OfferRow('Notice Period', '30 days'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Platform Fee ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.amber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.amber.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HireIQ Platform Fee',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryNavy),
                      ),
                      Text(
                        '10% of first-year salary',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: HireIQTheme.textMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due on start date',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: HireIQTheme.textMuted),
                      ),
                      Text(
                        'R72,000',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── ShieldIQ Agreements ───────────────────────────────────────
            Text(
              'Agreements',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            _AgreementCheckbox(
              label:
                  'I acknowledge the ShieldIQ guarantee terms — if this candidate leaves within 3 months, I receive a free replacement.',
              value: _agreeShieldiq,
              onChanged: (v) => setState(() => _agreeShieldiq = v),
            ),
            const SizedBox(height: 10),
            _AgreementCheckbox(
              label:
                  'I agree to the HireIQ Terms of Service and confirm this offer has been communicated to the candidate.',
              value: _agreeTerms,
              onChanged: (v) => setState(() => _agreeTerms = v),
            ),
            const SizedBox(height: 28),

            // ── Confirm Button ────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    _agreeShieldiq && _agreeTerms ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  disabledBackgroundColor:
                      HireIQTheme.borderLight,
                  disabledForegroundColor: HireIQTheme.textMuted,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
                child: Text(
                  'Confirm Hire & Send Offer',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _OfferRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
            fontSize: 13, color: HireIQTheme.textMuted),
      ),
      Text(
        value,
        style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy),
      ),
    ],
  );
}

class _AgreementCheckbox extends StatelessWidget {
  const _AgreementCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: HireIQTheme.primaryTeal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(
                label,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                    height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
