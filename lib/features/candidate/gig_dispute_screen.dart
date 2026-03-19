import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigDisputeScreen extends ConsumerStatefulWidget {
  const GigDisputeScreen({super.key});

  @override
  ConsumerState<GigDisputeScreen> createState() => _GigDisputeScreenState();
}

class _GigDisputeScreenState extends ConsumerState<GigDisputeScreen> {
  String _reason = '';
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: HireIQTheme.primaryNavy),
        title: Text(
          'Raise a Dispute',
          style: GoogleFonts.inter(
            color: HireIQTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HireIQTheme.error.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                  color: HireIQTheme.error.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 20,
                    color: HireIQTheme.error,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Raising a dispute will pause all milestone payments until resolved.',
                      style: GoogleFonts.inter(
                        color: HireIQTheme.error,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Raise a dispute',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 16),

            // Contract summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Contract:',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Mobile App Development — FinCorp SA',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        'Active milestone:',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'API Integration',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.primaryNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Reason for dispute',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select reason',
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
              ),
              value: _reason.isEmpty ? null : _reason,
              items: [
                'Work not delivered',
                'Quality issues',
                'Scope change without agreement',
                'Payment dispute',
                'Other',
              ]
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          color: HireIQTheme.primaryNavy,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _reason = value ?? '';
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _description,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Describe the issue',
                hintText: 'Provide details...',
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
              ),
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('File upload coming soon'),
                    ),
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_file_rounded,
                        size: 28,
                        color: HireIQTheme.textLight,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Attach evidence (optional)',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_reason.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a reason'),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Dispute submitted. Our team will review within 24 hours.',
                      ),
                    ),
                  );
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                ),
                child: Text(
                  'Submit Dispute',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(color: HireIQTheme.textMuted),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Disputes are typically resolved within 3-5 business days. Both parties will be notified of the outcome.',
              style: GoogleFonts.inter(
                color: HireIQTheme.textLight,
                fontSize: 12,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
