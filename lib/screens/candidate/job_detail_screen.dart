import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TabBar(
                    controller: _tabController,
                    labelColor: HireIQColors.navy,
                    unselectedLabelColor: HireIQColors.textMuted,
                    indicatorColor: HireIQColors.teal,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Description'),
                      Tab(text: 'Requirements'),
                      Tab(text: 'Company'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDescriptionTab(),
                        _buildRequirementsTab(),
                        _buildCompanyTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 30,
        left: 20,
        right: 20,
      ),
      color: HireIQColors.background,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go('/job-feed'),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              const Text(
                'Job Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: HireIQColors.navy,
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
                icon: Icon(
                  _isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: _isBookmarked ? HireIQColors.teal : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://logo.clearbit.com/google.com',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.business,
                    size: 40, color: HireIQColors.teal),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Senior Full-Stack Developer',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: HireIQColors.navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Google Inc. • San Francisco (Remote)',
            style: TextStyle(
              fontSize: 14,
              color: HireIQColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '\$120k - \$160k',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HireIQColors.teal,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About the Role',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          const SizedBox(height: 12),
          const Text(
            'HireIQ is looking for a Senior Full-Stack Developer to lead our core engineering team. You will be responsible for architecting and building scalable solutions that power the future of recruitment tech.',
            style: TextStyle(
                color: HireIQColors.textMuted, height: 1.6, fontSize: 15),
          ),
          const SizedBox(height: 12),
          const Text(
            "We work with React, Node.js, and PostgreSQL. You'll have the autonomy to make high-impact technical decisions and mentor junior engineers in a fast-paced, collaborative environment.",
            style: TextStyle(
                color: HireIQColors.textMuted, height: 1.6, fontSize: 15),
          ),
          const SizedBox(height: 24),
          const Text(
            'Key Responsibilities',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          const SizedBox(height: 12),
          _buildBulletPoint(
              'Design and implement high-performance web applications using modern frameworks.'),
          _buildBulletPoint(
              'Collaborate with product managers and designers to translate requirements into technical specs.'),
          _buildBulletPoint(
              'Conduct code reviews and maintain high standards for code quality and testing.'),
          _buildBulletPoint(
              'Optimize application for maximum speed and scalability.'),
        ],
      ),
    );
  }

  Widget _buildRequirementsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What We\'re Looking For',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          const SizedBox(height: 12),
          _buildBulletPoint(
              '6+ years of experience in Full-Stack Development.'),
          _buildBulletPoint(
              'Expertise in JavaScript/TypeScript, React, and Node.js.'),
          _buildBulletPoint(
              'Strong understanding of database design and SQL (PostgreSQL).'),
          _buildBulletPoint('Experience with cloud services (AWS/GCP).'),
          _buildBulletPoint(
              'Excellent problem-solving and communication skills.'),
        ],
      ),
    );
  }

  Widget _buildCompanyTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Company',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          SizedBox(height: 12),
          Text(
            'Google’s mission is to organize the world’s information and make it universally accessible and useful. HireIQ is a special unit focused on next-gen talent ecosystems.',
            style: TextStyle(
                color: HireIQColors.textMuted, height: 1.6, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(Icons.circle, size: 6, color: HireIQColors.teal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: HireIQColors.textMuted, fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: HireIQColors.silver.withValues(alpha: 0.5))),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () => context.go('/smart-apply'),
          child: const Text('Smart Apply with AI'),
        ),
      ),
    );
  }
}
