import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class WildcardScoreDetail extends StatelessWidget {
  const WildcardScoreDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('WildcardIQ Detail'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildScoreHeader(),
            const SizedBox(height: 40),
            _buildSkillBreakdown(),
            const SizedBox(height: 40),
            _buildVisibilityStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: 0.847,
                strokeWidth: 12,
                backgroundColor: HireIQTheme.primary.withAlpha(25),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(HireIQTheme.primary),
              ),
            ),
            Column(
              children: [
                Text('847',
                    style: HireIQTheme.titleStyle.copyWith(fontSize: 48)),
                Text('WildcardIQ',
                    style: HireIQTheme.bodyStyle
                        .copyWith(color: HireIQTheme.textSecondary)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Top 12% of all candidates',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skill Breakdown', style: HireIQTheme.subtitleStyle),
        const SizedBox(height: 20),
        _buildSkillRow('Problem solving', 92),
        const SizedBox(height: 15),
        _buildSkillRow('Technical aptitude', 88),
        const SizedBox(height: 15),
        _buildSkillRow('Communication', 79),
        const SizedBox(height: 15),
        _buildSkillRow('Adaptability', 84),
      ],
    );
  }

  Widget _buildSkillRow(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: HireIQTheme.bodyStyle),
            Text('$value%',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: HireIQTheme.border,
            valueColor: AlwaysStoppedAnimation<Color>(
                HireIQTheme.primary.withAlpha(178)),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilityStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.visibility, color: HireIQTheme.primary),
              const SizedBox(width: 15),
              Expanded(
                child: Text('Visibility Status',
                    style: HireIQTheme.subtitleStyle.copyWith(fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Your score is visible to employers through our blind screening process. This ensures merit-first evaluation of your core skills.',
            style: HireIQTheme.bodyStyle
                .copyWith(color: HireIQTheme.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }
}
