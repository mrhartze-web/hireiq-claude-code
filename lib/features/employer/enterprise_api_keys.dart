import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseApiKeysScreen extends ConsumerWidget {
  const EnterpriseApiKeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'API Keys',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const _ComingSoonBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API key management',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Create and manage API keys for your integrations.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.background,
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: HireIQTheme.primaryNavy.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.vpn_key_outlined,
                          size: 24,
                          color: HireIQTheme.primaryNavy,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Production key',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: HireIQTheme.primaryNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'hiq_prod_••••••••••••4f2a',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: HireIQTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: HireIQTheme.success.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            'Active',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: HireIQTheme.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureCard(
                    icon: Icons.add_circle_outline,
                    title: 'Create keys',
                    subtitle: 'Generate new API keys for different environments',
                  ),
                  _buildFeatureCard(
                    icon: Icons.block_outlined,
                    title: 'Revoke keys',
                    subtitle: 'Instantly revoke compromised or unused keys',
                  ),
                  _buildFeatureCard(
                    icon: Icons.tune_outlined,
                    title: 'Scope permissions',
                    subtitle: 'Restrict keys to specific API endpoints and methods',
                  ),
                  _buildFeatureCard(
                    icon: Icons.history_outlined,
                    title: 'Audit log',
                    subtitle: 'Track every API call made with each key',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: HireIQTheme.primaryNavy),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComingSoonBanner extends StatelessWidget {
  const _ComingSoonBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: HireIQTheme.primaryNavy,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Enterprise — Available Soon',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.amber,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              'Soon',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: HireIQTheme.primaryNavy,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You will be notified when Enterprise launches.'),
              ),
            ),
            child: Text(
              'Join Waitlist',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: HireIQTheme.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
