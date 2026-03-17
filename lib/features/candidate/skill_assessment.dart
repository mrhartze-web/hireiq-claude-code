import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class SkillAssessmentScreen extends StatefulWidget {
  const SkillAssessmentScreen({super.key});

  @override
  State<SkillAssessmentScreen> createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  final int _currentQuestion = 1;
  final int _totalQuestions = 15;
  final double _timerProgress = 0.7; // Mock timer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkillIQ Assessment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _timerProgress,
            backgroundColor: HireIQTheme.borderLight,
            color: HireIQTheme.primaryTeal,
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question $_currentQuestion of $_totalQuestions',
                    style: const TextStyle(
                        color: HireIQTheme.textMuted,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Which of the following is the most efficient way to manage state in a large-scale Flutter application with complex dependencies?',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
                  ),
                  const SizedBox(height: 40),
                  _buildOption('A', 'setState() exclusively'),
                  _buildOption('B',
                      'Using a combination of Riverpod and immutable data models',
                      isSelected: true),
                  _buildOption('C', 'Global variables and singletons'),
                  _buildOption('D',
                      'Passing data through the constructor chain (Prop drilling)'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HireIQTheme.primaryNavy,
                        foregroundColor: Colors.white),
                    child: const Text('Next Question'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? HireIQTheme.primaryTeal.withAlpha(25)
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 14,
          backgroundColor:
              isSelected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(text,
            style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        onTap: () {},
      ),
    );
  }
}
