import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerDispute extends ConsumerStatefulWidget {
  const EmployerDispute({super.key});

  @override
  ConsumerState<EmployerDispute> createState() => _EmployerDisputeState();
}

class _EmployerDisputeState extends ConsumerState<EmployerDispute> {
  String _selectedReason = '';
  final _reasons = [
    'Candidate no-show',
    'CV misrepresentation',
    'Candidate withdrew after offer',
    'Background check failed',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Raise a Dispute',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── ShieldIQ Banner ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_rounded,
                        color: HireIQTheme.primaryTeal, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ShieldIQ Protection',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Your placement is covered. Disputes are typically resolved within 3 business days.',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: HireIQTheme.textMuted,
                              height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Candidate Reference ───────────────────────────────────────
            Text(
              'Related Placement',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor:
                        HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    child: Text(
                      'AK',
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
                          'Ayanda Khumalo',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Senior Flutter Developer • Hired Mar 2026',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Dispute Reason ────────────────────────────────────────────
            Text(
              'Dispute Reason',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            Container(
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
                children: _reasons.asMap().entries.map((e) {
                  final reason = e.value;
                  final isLast = e.key == _reasons.length - 1;
                  final isSelected = reason == _selectedReason;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () =>
                            setState(() => _selectedReason = reason),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  reason,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? HireIQTheme.primaryNavy
                                          : HireIQTheme.textPrimary),
                                ),
                              ),
                              Radio<String>(
                                value: reason,
                                groupValue: _selectedReason,
                                onChanged: (v) => setState(
                                    () => _selectedReason = v ?? ''),
                                activeColor: HireIQTheme.primaryTeal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // ── Description ───────────────────────────────────────────────
            Text(
              'Additional Details',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: 5,
              style:
                  GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Describe the issue with as much detail as possible...',
                hintStyle: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, fontSize: 13),
                filled: true,
                fillColor: HireIQTheme.surfaceWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  borderSide: const BorderSide(
                      color: HireIQTheme.primaryTeal, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 24),

            // ── Submit ────────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _selectedReason.isNotEmpty ? () {} : null,
                icon: const Icon(Icons.shield_rounded, size: 18),
                label: Text(
                  'Submit Dispute to ShieldIQ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: HireIQTheme.borderLight,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
