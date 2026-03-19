import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _salaryController = TextEditingController();
  double _feePercent = 12.0;

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final salary = _salaryController.text;
    final parsedSalary =
        int.tryParse(salary.replaceAll(',', '').replaceAll(' ', ''));
    final double? calculatedFee =
        parsedSalary != null ? parsedSalary * _feePercent / 100 : null;

    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Confirm Hire',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Candidate being hired
            Text(
              'Candidate being hired',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
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
                    radius: 24,
                    backgroundColor: HireIQTheme.primaryNavy,
                    child: Text(
                      'TN',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thabo Nkosi',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Senior Flutter Developer',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryTeal
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                              ),
                              child: Text(
                                'MatchIQ 94%',
                                style: GoogleFonts.inter(
                                  color: HireIQTheme.primaryTeal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
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

            const SizedBox(height: 16),
            Text(
              'Position',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Text(
                'Senior Flutter Developer at FinCorp SA',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Placement fee calculator',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            // Placement fee card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: 'Annual Salary (R)',
                      labelStyle: GoogleFonts.inter(
                          color: HireIQTheme.textMuted, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        borderSide:
                            const BorderSide(color: HireIQTheme.borderLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        borderSide:
                            const BorderSide(color: HireIQTheme.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        borderSide:
                            const BorderSide(color: HireIQTheme.primaryTeal),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Fee Percentage',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<double>(
                        value: _feePercent,
                        underline: const SizedBox(),
                        items: [10.0, 12.0, 15.0]
                            .map(
                              (v) => DropdownMenuItem<double>(
                                value: v,
                                child: Text(
                                  '${v.toStringAsFixed(0)}%',
                                  style: GoogleFonts.inter(
                                    color: HireIQTheme.primaryNavy,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _feePercent = v);
                        },
                      ),
                    ],
                  ),
                  if (salary.isNotEmpty && calculatedFee != null) ...[
                    const SizedBox(height: 16),
                    const Divider(color: HireIQTheme.borderLight),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calculated Fee',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'R${calculatedFee.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Platform cut (20%)',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'R${(calculatedFee * 0.2).toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recruiter earnings (80%)',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'R${(calculatedFee * 0.8).toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Hire confirmed! Notifications sent.'),
                    ),
                  );
                  context.go('/employer');
                },
                child: Text(
                  'Confirm Hire',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: HireIQTheme.textMuted,
                ),
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
