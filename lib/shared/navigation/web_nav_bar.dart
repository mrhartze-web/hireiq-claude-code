import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class WebNavBar extends StatelessWidget implements PreferredSizeWidget {
  const WebNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.go('/'),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.work_outline,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'HireIQ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Central Navigation Links
            Row(
              children: [
                _buildNavLink(
                    context, 'Find Jobs', '/web/candidate/job-search'),
                const SizedBox(width: 30),
                _buildNavLink(
                    context, 'Hire Talent', '/web/employer/dashboard'),
                const SizedBox(width: 30),
                _buildNavLink(
                    context, 'For Recruiters', '/web/recruiter/dashboard'),
                const SizedBox(width: 30),
                _buildNavLink(context, 'Pricing', '/pricing'),
              ],
            ),

            // User Actions
            Row(
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'JD',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
