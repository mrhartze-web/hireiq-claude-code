import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateCareerGoals extends StatelessWidget {
  const CandidateCareerGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Career Goals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set your goals',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'MatchIQ uses this to find the perfect roles for you.',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 32),
            _buildTextField(
                label: 'Desired Role', hint: 'e.g. Senior Flutter Developer'),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Industry', hint: 'e.g. FinTech, Healthcare'),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Salary Target (ZAR / year)',
                hint: 'e.g. 800000',
                keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Preferred Location', hint: 'e.g. Cape Town, Remote'),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Career goals updated successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Goals',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: HireIQTheme.textMuted),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: HireIQTheme.primaryTeal, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
