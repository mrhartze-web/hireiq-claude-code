import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CareerUpliftPathScreen extends StatefulWidget {
  const CareerUpliftPathScreen({super.key});

  @override
  State<CareerUpliftPathScreen> createState() => _CareerUpliftPathScreenState();
}

class _CareerUpliftPathScreenState extends State<CareerUpliftPathScreen> {
  int _currentIndex = 0;

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
          'Career Path',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentRole(context),
            const SizedBox(height: 32),
            const Text(
              'Recommended Next Steps',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 16),
            _buildRoleStep('Recruitment Manager', '85% Skill Match'),
            _buildRoleStep('Talent Acquisition Director', '60% Skill Match'),
            _buildRoleStep('HR Business Partner', '72% Skill Match'),
            const SizedBox(height: 40),
            _buildGapBridgeSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) context.go('/job-feed');
          if (index == 1) context.go('/application-tracker');
          if (index == 2) context.go('/candidate-profile');
          if (index == 3) context.go('/settings');
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HireIQColors.teal,
        unselectedItemColor: HireIQColors.textMuted,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center_rounded), label: 'Applications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildCurrentRole(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: HireIQColors.navy.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: HireIQColors.teal,
            child: Icon(Icons.person, size: 36, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Role',
                style: TextStyle(
                    color: HireIQColors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Senior Recruiter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Top 5% in industry',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleStep(String title, String match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: HireIQColors.navy),
              ),
              const SizedBox(height: 4),
              Text(
                match,
                style: const TextStyle(
                    color: HireIQColors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: HireIQColors.silver),
        ],
      ),
    );
  }

  Widget _buildGapBridgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bridge the Gap',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQColors.navy),
        ),
        const SizedBox(height: 16),
        _buildSkillResource('Strategic People Management 101',
            'Management Excellence', Icons.school),
        _buildSkillResource('Data-Driven Recruitment Strategies',
            'Analytics Talent Hub', Icons.analytics),
      ],
    );
  }

  Widget _buildSkillResource(String title, String provider, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: HireIQColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: HireIQColors.teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: HireIQColors.navy),
                ),
                Text(
                  provider,
                  style: const TextStyle(
                      color: HireIQColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.launch_rounded,
              size: 16, color: HireIQColors.silver),
        ],
      ),
    );
  }
}
