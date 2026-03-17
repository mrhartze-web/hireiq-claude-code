import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerCandidateSearch extends StatelessWidget {
  const EmployerCandidateSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Advanced Search'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Candidates',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTextField(
                'Skills (comma separated)', 'e.g. Flutter, Dart, Firebase'),
            const SizedBox(height: 20),
            _buildTextField('Location', 'e.g. Remote, Johannesburg'),
            const SizedBox(height: 20),
            const Text('Minimum MatchIQ Score',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: 80,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    activeColor: HireIQTheme.primaryTeal,
                    inactiveColor: HireIQTheme.borderLight,
                    onChanged: (val) {},
                  ),
                ),
                const Text('80%',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: SwitchListTile(
                title: const Text('PassportIQ Verified Only',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                subtitle: const Text(
                    'Only show candidates with verified identity and qualifications.',
                    style: TextStyle(color: HireIQTheme.textMuted)),
                value: true,
                onChanged: (val) {},
                activeThumbColor: HireIQTheme.primaryTeal,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Apply Filters',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        TextField(
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
          ),
        ),
      ],
    );
  }
}
