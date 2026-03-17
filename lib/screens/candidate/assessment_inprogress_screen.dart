import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class AssessmentInprogressScreen extends StatelessWidget {
  const AssessmentInprogressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_outlined, size: 18, color: HireIQColors.teal),
            SizedBox(width: 8),
            Text('14:52',
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: HireIQColors.navy)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => context.go('/job-feed'),
              child: const Text('Quit')),
        ],
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(
              value: 0.45, color: HireIQColors.teal, minHeight: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Question 12 of 20',
                      style: TextStyle(
                          color: HireIQColors.textMuted,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  const SizedBox(height: 16),
                  const Text(
                    'Which of the following hooks is used to handle side effects in a functional React component?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQColors.navy),
                  ),
                  const SizedBox(height: 32),
                  _buildOption('useState'),
                  _buildOption('useEffect', isSelected: true),
                  _buildOption('useContext'),
                  _buildOption('useReducer'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => context.go('/assessment-result'),
                    child: const Text('Next →'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected
            ? HireIQColors.teal.withValues(alpha: 0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isSelected ? HireIQColors.teal : HireIQColors.silver),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? HireIQColors.teal : HireIQColors.navy)),
          if (isSelected)
            const Icon(Icons.check_circle_rounded,
                color: HireIQColors.teal, size: 20),
        ],
      ),
    );
  }
}
