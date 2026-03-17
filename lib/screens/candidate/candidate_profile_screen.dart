import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateProfileScreen extends StatefulWidget {
  const CandidateProfileScreen({super.key});

  @override
  State<CandidateProfileScreen> createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'Candidate Passport',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/edit-profile'),
            icon: const Icon(Icons.edit_outlined, color: HireIQColors.navy),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 10),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSkillsTab(),
                _buildExperienceTab(),
                _buildEducationTab(),
                _buildTestsTab(),
              ],
            ),
          ),
        ],
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

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: HireIQColors.background,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: HireIQColors.teal, width: 3),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/300?u=alex'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: HireIQColors.teal,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.verified, size: 20, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Alex Thompson',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: HireIQColors.navy),
          ),
          const SizedBox(height: 4),
          const Text(
            'San Francisco, CA',
            style: TextStyle(fontSize: 14, color: HireIQColors.textMuted),
          ),
          const SizedBox(height: 16),
          const Text(
            'Senior Product Designer with 6+ years of experience building scalable design systems and user-centric mobile applications.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: HireIQColors.textMuted, height: 1.5),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => context.go('/skill-assessment'),
                child: _buildStat('92', 'Wildcard Score'),
              ),
              _buildStat('15', 'Projects'),
              _buildStat('4.9', 'Rating'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: HireIQColors.navy),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: HireIQColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: HireIQColors.teal,
      unselectedLabelColor: HireIQColors.textMuted,
      indicatorColor: HireIQColors.teal,
      indicatorWeight: 3,
      isScrollable: true,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(text: 'Skills'),
        Tab(text: 'Experience'),
        Tab(text: 'Education'),
        Tab(text: 'Tests'),
      ],
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Core Expertise',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQColors.navy),
              ),
              TextButton.icon(
                onPressed: () => context.go('/video_pitch'),
                icon: const Icon(Icons.videocam_rounded, size: 18),
                label: const Text('Video Pitch'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            children: [
              _buildSkillChip('Product Design', true),
              _buildSkillChip('UX Architecture', true),
              _buildSkillChip('Design Systems', true),
              _buildSkillChip('Figma Expert', true),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Secondary Skills',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          const SizedBox(height: 16),
          Wrap(
            children: [
              _buildSkillChip('React Native', false),
              _buildSkillChip('User Research', false),
              _buildSkillChip('A/B Testing', false),
            ],
          ),
          const SizedBox(height: 32),
          _buildAssessmentInsight(),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => context.go('/career-uplift'),
            child: _buildCareerUplift(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, bool isCore) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isCore
            ? HireIQColors.teal.withValues(alpha: 0.1)
            : HireIQColors.silver.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: isCore ? HireIQColors.teal : HireIQColors.silver),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isCore ? HireIQColors.teal : HireIQColors.textMuted,
          fontWeight: isCore ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAssessmentInsight() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: HireIQColors.teal, size: 20),
              SizedBox(width: 8),
              Text(
                'Assessment Insight',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Alex excels in problem-solving and visual hierarchy, scoring in the top 5% of candidates for UI consistency.',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13,
                height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerUplift() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.teal.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.upgrade_rounded, color: HireIQColors.teal, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Career Uplift Path',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HireIQColors.navy),
                ),
                Text(
                  'Personalized recommendations to level up.',
                  style: TextStyle(color: HireIQColors.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: HireIQColors.silver),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return const Center(child: Text('Experience Timeline'));
  }

  Widget _buildEducationTab() {
    return const Center(child: Text('Education History'));
  }

  Widget _buildTestsTab() {
    return const Center(child: Text('Skill Assessment Results'));
  }
}
