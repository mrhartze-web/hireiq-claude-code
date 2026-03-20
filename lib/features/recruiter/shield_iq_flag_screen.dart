import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ShieldIqFlagScreen extends ConsumerStatefulWidget {
  const ShieldIqFlagScreen({super.key});

  @override
  ConsumerState<ShieldIqFlagScreen> createState() => _ShieldIqFlagScreenState();
}

class _ShieldIqFlagScreenState extends ConsumerState<ShieldIqFlagScreen> {
  String _selectedFlag = '';

  final _flags = [
    'Misrepresentation on CV',
    'Failed background check',
    'Non-disclosure of criminal record',
    'Fraudulent credentials',
    'Threatening behaviour',
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
        title: Text('ShieldIQ Flag',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.error.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.error.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: HireIQTheme.error.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.shield_rounded, color: HireIQTheme.error, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Flag a Candidate Concern', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                        const SizedBox(height: 2),
                        Text('Flagged candidates are reviewed within 24 hours. Verified flags protect the entire HireIQ community.',
                            style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Candidate Ref
            Text('Candidate', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HireIQTheme.error.withValues(alpha: 0.1),
                    child: Text('ZM', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.error)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Zanele Mokoena', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                      Text('Applied: UX Designer — OUTsurance', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Flag Reasons
            Text('Flag Reason', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                children: _flags.asMap().entries.map((e) {
                  final isLast = e.key == _flags.length - 1;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => setState(() => _selectedFlag = e.value),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(e.value,
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: e.value == _selectedFlag ? FontWeight.w700 : FontWeight.w400,
                                        color: e.value == _selectedFlag ? HireIQTheme.primaryNavy : HireIQTheme.textPrimary)),
                              ),
                              Radio<String>(
                                value: e.value,
                                groupValue: _selectedFlag,
                                onChanged: (v) => setState(() => _selectedFlag = v ?? ''),
                                activeColor: HireIQTheme.error,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              maxLines: 4,
              style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Provide supporting details...',
                hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
                filled: true,
                fillColor: HireIQTheme.surfaceWhite,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), borderSide: const BorderSide(color: HireIQTheme.borderLight)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), borderSide: const BorderSide(color: HireIQTheme.borderLight)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), borderSide: const BorderSide(color: HireIQTheme.error, width: 1.5)),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _selectedFlag.isNotEmpty ? () {} : null,
                icon: const Icon(Icons.flag_rounded, size: 18),
                label: Text('Submit Flag to ShieldIQ', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.error,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: HireIQTheme.borderLight,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
