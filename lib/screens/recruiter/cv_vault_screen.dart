import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CvVaultScreen extends StatelessWidget {
  const CvVaultScreen({super.key});

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
          'CV Vault',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.cloud_upload_outlined)),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildCvItem(
                    'Alex Rivera', 'Senior Product Designer', 'Matched 2d ago'),
                _buildCvItem(
                    'Sarah Chen', 'Full Stack Engineer', 'Matched 3d ago'),
                _buildCvItem(
                    'Marcus Thompson', 'Backend Lead', 'Matched 5d ago'),
                _buildCvItem(
                    'Elena Rodriguez', 'Data Scientist', 'Matched 1w ago'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: HireIQColors.silver.withValues(alpha: 0.5))),
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search roles, skills, or candidates...',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: HireIQColors.background,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip('All Talent', true),
                _filterChip('Top 1%', false),
                _filterChip('Engineering', false),
                _filterChip('Design', false),
                _filterChip('Recently Added', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? HireIQColors.teal : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isSelected ? HireIQColors.teal : HireIQColors.silver),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : HireIQColors.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
  }

  Widget _buildCvItem(String name, String role, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf_rounded,
              color: Colors.redAccent, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HireIQColors.navy)),
                Text(role,
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.more_vert_rounded,
                  size: 20, color: HireIQColors.textMuted),
              const Spacer(),
              Text(time,
                  style: TextStyle(
                      color: HireIQColors.textMuted.withValues(alpha: 0.6),
                      fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
