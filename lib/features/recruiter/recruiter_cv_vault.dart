import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class RecruiterCVVault extends StatelessWidget {
  const RecruiterCVVault({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Vault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by skill, name or role...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
                filled: true,
                fillColor: HireIQTheme.surfaceWhite,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCvFile('alex_rivera_resume.pdf',
                    'Flutter, Firebase, Dart', 'Expert'),
                _buildCvFile('sophia_m_portfolio.pdf', 'UI/UX, Figma, Web',
                    'Intermediate'),
                _buildCvFile(
                    'james_bond_cv.pdf', 'Security, Cloud, DevOps', 'Expert'),
                _buildCvFile(
                    'lisa_wong_cv.pdf', 'Python, AI, Data Science', 'Expert'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: HireIQTheme.primaryNavy,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCvFile(String filename, String skills, String level) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red[50], // PDF icon background
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.picture_as_pdf, color: Colors.red),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(filename,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(skills,
                    style: const TextStyle(
                        fontSize: 12, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(level,
                style: const TextStyle(
                    color: HireIQTheme.primaryTeal,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
