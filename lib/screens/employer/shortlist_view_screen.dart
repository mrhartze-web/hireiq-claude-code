import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ShortlistViewScreen extends StatelessWidget {
  const ShortlistViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Shortlist',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildJobSelector(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildCandidateRow(context, 'Alex Rivera',
                    'Senior Product Designer', '92%', true),
                _buildCandidateRow(
                    context, 'Elena Soph', 'Lead UX Researcher', '88%', false),
                _buildCandidateRow(
                    context, 'Marcus Chen', 'Fullstack Engineer', '85%', false),
                _buildCandidateRow(
                    context, 'Sarah Miller', 'UI Designer', '82%', true),
                _buildCandidateRow(
                    context, 'David Park', 'frontend Developer', '79%', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: HireIQColors.silver.withValues(alpha: 0.5))),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing for: Senior Designer',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: HireIQColors.navy),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, color: HireIQColors.teal),
        ],
      ),
    );
  }

  Widget _buildCandidateRow(BuildContext context, String name, String role,
      String score, bool isInterviewing) {
    return GestureDetector(
      onTap: () => context.push('/candidate-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HireIQColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: HireIQColors.silver),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: HireIQColors.silver,
              child: Icon(Icons.person, color: HireIQColors.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HireIQColors.navy),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  if (isInterviewing)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: HireIQColors.teal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Interview Scheduled',
                        style: TextStyle(
                            color: HireIQColors.teal,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Match Score',
                  style: TextStyle(fontSize: 10, color: HireIQColors.textMuted),
                ),
                Text(
                  score,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HireIQColors.teal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
