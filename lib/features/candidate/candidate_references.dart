import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateReferences extends StatelessWidget {
  const CandidateReferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('References'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your References',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 16),
          _buildReferenceCard(
              'Jane Doe', 'Engineering Manager, Apex Digital', true),
          _buildReferenceCard(
              'John Smith', 'Lead Developer, FinTech Startup', false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: HireIQTheme.primaryTeal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildReferenceCard(String name, String role, bool verified) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
          child: Text(name[0],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQTheme.primaryTeal)),
        ),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(role, style: const TextStyle(color: HireIQTheme.textMuted)),
            const SizedBox(height: 8),
            if (verified)
              const Row(
                children: [
                  Icon(Icons.verified,
                      color: HireIQTheme.primaryTeal, size: 14),
                  SizedBox(width: 4),
                  Text('Verified Reference',
                      style: TextStyle(
                          color: HireIQTheme.primaryTeal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              )
            else
              const Row(
                children: [
                  Icon(Icons.schedule, color: HireIQTheme.warning, size: 14),
                  SizedBox(width: 4),
                  Text('Pending Verification',
                      style: TextStyle(
                          color: HireIQTheme.warning,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.edit_outlined,
                    color: HireIQTheme.primaryNavy),
                onPressed: () {}),
            IconButton(
                icon:
                    const Icon(Icons.delete_outline, color: HireIQTheme.error),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
