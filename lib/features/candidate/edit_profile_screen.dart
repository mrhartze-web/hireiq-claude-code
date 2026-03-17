import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Personal Info',
              children: [
                _buildTextField(
                    label: 'Full Name', initialValue: 'Thabo Nkosi'),
                _buildTextField(
                    label: 'Bio',
                    initialValue:
                        'Senior Flutter Developer with 5+ years of experience in fintech and mobile commerce.'),
                _buildTextField(
                    label: 'Location',
                    initialValue: 'Johannesburg, South Africa'),
              ],
            ),
            const SizedBox(height: 25),
            _buildSection(
              title: 'Work Experience',
              children: [
                _buildExperienceTile(
                    'Senior Flutter Developer', 'FinServ SA', '2021 - Present'),
                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Experience'),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45)),
                ),
              ],
            ),
            const SizedBox(height: 25),
            _buildSection(
              title: 'Skills',
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildSkillChip('Flutter'),
                    _buildSkillChip('Dart'),
                    _buildSkillChip('Riverpod'),
                    _buildSkillChip('Firebase'),
                    _buildSkillChip('Clean Architecture'),
                    _buildSkillChip('CI/CD'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: HireIQTheme.primary.withAlpha(25),
          child: const Icon(Icons.person, size: 50, color: HireIQTheme.primary),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: HireIQTheme.primary, shape: BoxShape.circle),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: HireIQTheme.subtitleStyle.copyWith(fontSize: 16)),
        const SizedBox(height: 15),
        ...children,
      ],
    );
  }

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: HireIQTheme.textSecondary)),
          TextField(
            controller: TextEditingController(text: initialValue),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTile(String title, String company, String period) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('$company • $period',
                  style: const TextStyle(
                      fontSize: 12, color: HireIQTheme.textSecondary)),
            ],
          ),
          const Icon(Icons.edit_outlined,
              size: 20, color: HireIQTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      deleteIcon: const Icon(Icons.close, size: 14),
      onDeleted: () {},
      backgroundColor: HireIQTheme.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: HireIQTheme.border)),
    );
  }
}
