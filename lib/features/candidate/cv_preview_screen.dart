import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CVPreviewScreen extends StatelessWidget {
  const CVPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('CV Preview'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download, color: HireIQTheme.primary),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: HireIQTheme.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const Divider(height: 40),
              _buildSectionTitle('Experience'),
              _buildExperienceItem(
                company: 'FinServ SA',
                role: 'Senior Flutter Developer',
                period: '2021 - Present',
                description:
                    'Led cross-platform mobile development for flagship banking apps with 1M+ active users.',
              ),
              _buildExperienceItem(
                company: 'TechFlow',
                role: 'Mobile Developer',
                period: '2019 - 2021',
                description:
                    'Developed and maintained the core mobile application using Flutter and Dart.',
              ),
              const Divider(height: 40),
              _buildSectionTitle('Expertise'),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildTag('Flutter'),
                  _buildTag('Dart'),
                  _buildTag('Riverpod'),
                  _buildTag('Firebase'),
                  _buildTag('Clean Architecture'),
                ],
              ),
              const Divider(height: 40),
              _buildSectionTitle('Education'),
              const Text('BSc Computer Science',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('University of Cape Town',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('THABO NKOSI',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            SizedBox(height: 5),
            Text('Senior Flutter Developer',
                style: TextStyle(color: HireIQTheme.primary, fontSize: 16)),
          ],
        ),
        Icon(Icons.contact_mail_outlined, size: 40, color: Colors.grey),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.grey),
      ),
    );
  }

  Widget _buildExperienceItem(
      {required String company,
      required String role,
      required String period,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(company,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(period,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(role,
              style: const TextStyle(
                  color: HireIQTheme.primary, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                  fontSize: 13, height: 1.4, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
