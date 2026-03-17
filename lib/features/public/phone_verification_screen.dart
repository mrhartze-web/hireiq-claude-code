import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: HireIQTheme.textPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verify your number', style: HireIQTheme.subtitleStyle),
            const SizedBox(height: 10),
            Text('Enter the 6-digit code', style: HireIQTheme.titleStyle),
            const SizedBox(height: 15),
            Text(
              'Sent to +27 82 ••• ••84',
              style: HireIQTheme.bodyStyle
                  .copyWith(color: HireIQTheme.textSecondary),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  List.generate(6, (index) => _buildOtpDigitField(context)),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Verify Account'),
            ),
            const SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Having trouble? Contact support'),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Your number is only used for account security and will not be shared with others or used for marketing.',
              textAlign: TextAlign.center,
              style: HireIQTheme.bodyStyle
                  .copyWith(fontSize: 12, color: HireIQTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpDigitField(BuildContext context) {
    return Container(
      width: 45,
      height: 60,
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
