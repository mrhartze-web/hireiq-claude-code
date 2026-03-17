import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerCandidatePipeline extends StatelessWidget {
  const EmployerCandidatePipeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Candidate Pipeline'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPipelineColumn('New', 3, [
              _buildKanbanCard('John Doe', 'Senior Developer', 92),
              _buildKanbanCard('Jane Smith', 'Frontend Dev', 88),
              _buildKanbanCard('Alice Johnson', 'Fullstack Engineer', 85),
            ]),
            _buildPipelineColumn('Reviewed', 2, [
              _buildKanbanCard('Bob Brown', 'UI/UX Designer', 90),
              _buildKanbanCard('Charlie Davis', 'Project Manager', 78),
            ]),
            _buildPipelineColumn('Shortlisted', 1, [
              _buildKanbanCard('David Evans', 'Backend Developer', 95),
            ]),
            _buildPipelineColumn('Interviewing', 2, [
              _buildKanbanCard('Eva Green', 'Data Scientist', 91),
              _buildKanbanCard('Frank White', 'DevOps Engineer', 89),
            ]),
            _buildPipelineColumn('Offered', 0, []),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineColumn(String title, int count, List<Widget> cards) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: HireIQTheme.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HireIQTheme.primaryNavy)),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Text('$count',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: HireIQTheme.primaryNavy)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: cards.isEmpty
                  ? [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text('No candidates in this stage',
                              style: TextStyle(color: HireIQTheme.textMuted)),
                        ),
                      )
                    ]
                  : cards,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(String name, String role, int matchIq) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
                  child: Text(name[0],
                      style: const TextStyle(
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.primaryNavy))),
              ],
            ),
            const SizedBox(height: 8),
            Text(role,
                style: const TextStyle(
                    color: HireIQTheme.textMuted, fontSize: 13)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withAlpha(25),
                  borderRadius: BorderRadius.circular(4)),
              child: Text('$matchIq% Match',
                  style: const TextStyle(
                      color: HireIQTheme.primaryTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
