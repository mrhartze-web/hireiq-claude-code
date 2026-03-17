import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/candidate-profile'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/candidate-profile'),
            child: const Text('Save Changes'),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildAvatarSection(),
            const SizedBox(height: 32),
            _buildTextField('Full Name', 'Alex Thompson'),
            const SizedBox(height: 16),
            _buildTextField(
                'Professional Headline', 'Senior Product Architect'),
            const SizedBox(height: 16),
            _buildTextField(
                'Bio', 'Digital architect with a decade of experience...',
                maxLines: 4),
            const SizedBox(height: 32),
            _buildSectionHeader('Availability'),
            _buildSwitchItem('Open to Gigs', true),
            _buildSwitchItem('Open to Full-time', true),
            const SizedBox(height: 32),
            _buildSectionHeader('Documents'),
            _buildFileItem('Resume_2023.pdf'),
            _buildFileItem('Portfolio_v2.pdf'),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.go('/candidate-profile'),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: HireIQColors.teal,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: HireIQColors.navy, shape: BoxShape.circle),
            child: const Icon(Icons.camera_alt_rounded,
                color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: HireIQColors.textMuted)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: HireIQColors.silver)),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchItem(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Switch.adaptive(
            value: value,
            onChanged: (v) {},
            activeTrackColor: HireIQColors.teal,
            activeThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(String filename) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: HireIQColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf_rounded, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
              child: Text(filename,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const Icon(Icons.more_vert_rounded, color: HireIQColors.silver),
        ],
      ),
    );
  }
}
