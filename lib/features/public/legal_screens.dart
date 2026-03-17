import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Text(
          '1. Acceptance of Terms\n\nBy accessing and using HireIQ, you agree to be bound by these Terms of Service...\n\n'
          '2. User Responsibilities\n\nYou are responsible for maintaining the confidentiality of your account credentials...\n\n'
          '3. Service Description\n\nHireIQ provides a platform for recruitment and job searching using AI matching technologies...\n\n'
          '4. Disclaimer\n\nThe services are provided "as is" without warranty of any kind...\n\n',
          style: TextStyle(height: 1.6),
        ),
      ),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Text(
          '1. Information We Collect\n\nWe collect information you provide directly to us, such as your name, email, and CV data...\n\n'
          '2. How We Use Information\n\nWe use your information to facilitate matches between candidates and employers...\n\n'
          '3. Data Protection\n\nWe implement industry-standard security measures to protect your personal data...\n\n'
          '4. Third-Party Sharing\n\nWe do not sell your personal information to third parties...\n\n',
          style: TextStyle(height: 1.6),
        ),
      ),
    );
  }
}
