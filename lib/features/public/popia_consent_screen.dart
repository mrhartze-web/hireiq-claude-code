import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class PopiaConsentScreen extends ConsumerStatefulWidget {
  const PopiaConsentScreen({super.key});

  @override
  ConsumerState<PopiaConsentScreen> createState() => _PopiaConsentScreenState();
}

class _PopiaConsentScreenState extends ConsumerState<PopiaConsentScreen> {
  bool _profileData = true;
  bool _cvData = true;
  bool _commsPrefs = false;
  bool _marketing = false;

  bool get _canContinue => _profileData && _cvData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hire',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  TextSpan(
                    text: 'IQ',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Icon(
                Icons.shield_outlined,
                size: 56,
                color: HireIQTheme.primaryTeal,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Your data is protected',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'HireIQ collects and processes your personal information in accordance with the Protection of Personal Information Act (POPIA).',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            _ConsentItem(
              title: 'Profile data for matching',
              subtitle: 'Required to match you with relevant jobs',
              value: _profileData,
              onChanged: null,
            ),
            const SizedBox(height: 12),
            _ConsentItem(
              title: 'CV data processing',
              subtitle: 'Required to analyse and score your CV',
              value: _cvData,
              onChanged: null,
            ),
            const SizedBox(height: 12),
            _ConsentItem(
              title: 'Communication preferences',
              subtitle: 'Receive job alerts and updates',
              value: _commsPrefs,
              onChanged: (val) => setState(() => _commsPrefs = val),
            ),
            const SizedBox(height: 12),
            _ConsentItem(
              title: 'Marketing communications',
              subtitle: 'Receive product news and offers',
              value: _marketing,
              onChanged: (val) => setState(() => _marketing = val),
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton.icon(
                onPressed: () => context.push('/privacy'),
                icon: const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: HireIQTheme.primaryTeal,
                ),
                label: Text(
                  'Read our full Privacy Policy',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canContinue ? () => context.go('/candidate') : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _canContinue ? HireIQTheme.amber : HireIQTheme.borderLight,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  disabledBackgroundColor: HireIQTheme.borderLight,
                  disabledForegroundColor: HireIQTheme.textLight,
                ),
                child: Text(
                  'Agree and Continue',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'HireIQ complies with POPIA — Protection of Personal Information Act 2013',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: HireIQTheme.textLight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsentItem extends StatelessWidget {
  const _ConsentItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: Border.all(color: HireIQTheme.borderLight),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: HireIQTheme.primaryTeal,
          ),
        ],
      ),
    );
  }
}
