import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employer-dashboard'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Post a New Role',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepIndicator(),
              const SizedBox(height: 32),
              _buildFieldLabel('Job Title'),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'e.g. Senior Fullstack Developer'),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Job Type'),
              _buildDropdown(
                  ['Full-time', 'Part-time', 'Contract', 'Gig/Freelance']),
              const SizedBox(height: 20),
              _buildFieldLabel('Location'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'e.g. San Francisco (Remote)',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Salary Range'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Min (USD)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Max (USD)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFieldLabel('Description'),
              TextFormField(
                maxLines: 6,
                decoration: const InputDecoration(
                    hintText:
                        'Outline roles, responsibilities, and key perks...'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/my-jobs'),
                child: const Text('Post Job & Start AI Matching'),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Your mission: We find the best 1% for you.',
                  style: TextStyle(fontSize: 12, color: HireIQColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _buildStep(1, 'Details', true),
        _buildLine(true),
        _buildStep(2, 'Aptitude', false),
        _buildLine(false),
        _buildStep(3, 'Publish', false),
      ],
    );
  }

  Widget _buildStep(int num, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? HireIQColors.teal : HireIQColors.silver,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$num',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? HireIQColors.navy : HireIQColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? HireIQColors.teal : HireIQColors.silver,
        margin: const EdgeInsets.only(bottom: 20),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQColors.navy),
      ),
    );
  }

  Widget _buildDropdown(List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items[0],
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
