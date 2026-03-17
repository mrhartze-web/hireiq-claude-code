import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'What brings you here?',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select your primary goal to get started',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                    ),
              ),
              const SizedBox(height: 48),
              _RoleCard(
                title: 'Looking for work',
                subtitle: 'Find your next career move',
                icon: Icons.search_rounded,
                isSelected: _selectedRole == 'candidate',
                onTap: () {
                  setState(() => _selectedRole = 'candidate');
                  context.go('/candidate-onboarding-1');
                },
              ),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'Hiring talent',
                subtitle: 'Post jobs and find candidates',
                icon: Icons.business_center_outlined,
                isSelected: _selectedRole == 'employer',
                onTap: () {
                  setState(() => _selectedRole = 'employer');
                  context.go('/employer-onboarding-1');
                },
              ),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'I am a Recruiter',
                subtitle: 'Manage multiple clients and roles',
                icon: Icons.groups_outlined,
                isSelected: _selectedRole == 'recruiter',
                onTap: () {
                  setState(() => _selectedRole = 'recruiter');
                  context.go('/recruiter-dashboard');
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedRole == null
                    ? null
                    : () {
                        // Navigate to signup with selected role
                      },
                child: const Text('Continue'),
              ),
              const SizedBox(height: 24),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: "By continuing, you agree to HireIQ's ",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: const [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: HireIQColors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: HireIQColors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HireIQColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? HireIQColors.teal : HireIQColors.silver,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: HireIQColors.teal.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? HireIQColors.teal.withValues(alpha: 0.1)
                    : HireIQColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? HireIQColors.teal : HireIQColors.textMuted,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? HireIQColors.teal
                              : HireIQColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: HireIQColors.teal),
          ],
        ),
      ),
    );
  }
}
