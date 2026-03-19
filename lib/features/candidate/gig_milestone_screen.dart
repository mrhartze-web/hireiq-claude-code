import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigMilestoneScreen extends ConsumerStatefulWidget {
  const GigMilestoneScreen({super.key});

  @override
  ConsumerState<GigMilestoneScreen> createState() => _GigMilestoneScreenState();
}

class _GigMilestoneScreenState extends ConsumerState<GigMilestoneScreen> {
  final TextEditingController _notes = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _notes.dispose();
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
          'Milestone 3',
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
            // Status badge
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'In Progress',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Milestone info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API Integration',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Integrate all backend APIs and connect to the live FinCorp data feeds. Include error handling and loading states.',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due Date',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '20 Mar 2026',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.primaryNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Milestone Value',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'R15,000',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            if (!_submitted) ...[
              Text(
                'Submit your work',
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                height: 120,
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
                          Icons.upload_file_outlined,
                          size: 32,
                          color: HireIQTheme.textLight,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap to upload files',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'PDF, ZIP, or image',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textLight,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _notes,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Work notes',
                  hintText: 'Describe what you completed...',
                  border: const OutlineInputBorder(),
                  labelStyle:
                      GoogleFonts.inter(color: HireIQTheme.textMuted),
                ),
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _submitted = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Submitted! Awaiting client review.'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.amber,
                    foregroundColor: HireIQTheme.primaryNavy,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                    ),
                  ),
                  child: Text(
                    'Submit for Approval',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.hourglass_top_rounded,
                      size: 48,
                      color: HireIQTheme.amber,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Awaiting review',
                      style: GoogleFonts.inter(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your client has been notified. You'll hear back within 48 hours.",
                      style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted,
                        fontSize: 14,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
