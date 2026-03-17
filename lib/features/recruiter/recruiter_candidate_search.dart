import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterCandidateSearch extends StatelessWidget {
  const RecruiterCandidateSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Source Talent'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search skills, roles, or names...',
                hintStyle: const TextStyle(color: HireIQTheme.textMuted),
                filled: true,
                fillColor: Colors.white,
                prefixIcon:
                    const Icon(Icons.search, color: HireIQTheme.primaryNavy),
                suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.tune, color: HireIQTheme.primaryTeal),
                    onPressed: () {}),
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
            const SizedBox(height: 24),
            _buildQuickFilterRow(),
            const SizedBox(height: 32),
            _buildCandidateResult('Alice Johnson', 'Senior Flutter Developer',
                94, 'Available Now'),
            _buildCandidateResult('Bob Smith', 'Backend Engineer (Go)', 88,
                'Employed, Open to Offers'),
            _buildCandidateResult(
                'Charlie Davis', 'UI/UX Designer', 85, 'Actively Looking'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Top MatchIQ', true),
          const SizedBox(width: 8),
          _buildFilterChip('Verified Only', false),
          const SizedBox(width: 8),
          _buildFilterChip('Remote', false),
          const SizedBox(width: 8),
          _buildFilterChip('Senior (5+ yrs)', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {},
      selectedColor: HireIQTheme.primaryNavy,
      backgroundColor: HireIQTheme.surfaceWhite,
      labelStyle:
          TextStyle(color: isSelected ? Colors.white : HireIQTheme.primaryNavy),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
            color:
                isSelected ? HireIQTheme.primaryNavy : HireIQTheme.borderLight),
      ),
    );
  }

  Widget _buildCandidateResult(
      String name, String role, int score, String status) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: HireIQTheme.borderLight)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
          child: Text(name[0],
              style: const TextStyle(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
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
            Row(
              children: [
                const Icon(Icons.bolt,
                    color: HireIQTheme.primaryTeal, size: 16),
                const SizedBox(width: 4),
                Text('$score% Match',
                    style: const TextStyle(
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                const SizedBox(width: 12),
                Expanded(
                    child: Text(status,
                        style: const TextStyle(
                            color: HireIQTheme.textMuted, fontSize: 12),
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.person_add_alt_1,
              color: HireIQTheme.primaryNavy),
          onPressed: () {},
        ),
      ),
    );
  }
}
