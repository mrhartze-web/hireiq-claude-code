import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerPostGig extends StatelessWidget {
  const EmployerPostGig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Post a Gig'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Draft'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gig Details',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTextField('Project Title', 'e.g. Flutter UI Overhaul'),
            const SizedBox(height: 16),
            _buildTextField(
                'Description', 'Describe the project scope and deliverables...',
                maxLines: 5),
            const SizedBox(height: 32),
            const Text(
              'Requirements',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTextField(
                'Required Skills', 'e.g. Flutter, Firebase, Riverpod'),
            const SizedBox(height: 16),
            _buildDropdownField('Duration', 'Select duration'),
            const SizedBox(height: 32),
            const Text(
              'Budget & Payment',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTextField('Fixed Price (R)', 'e.g. 15000')),
                const SizedBox(width: 16),
                Expanded(
                    child:
                        _buildDropdownField('Payment Method', 'Select method')),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Publish Gig',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: HireIQTheme.textMuted),
            filled: true,
            fillColor: Colors.white,
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
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint,
                  style: const TextStyle(color: HireIQTheme.textMuted)),
              items: const [],
              onChanged: (val) {},
            ),
          ),
        ),
      ],
    );
  }
}
