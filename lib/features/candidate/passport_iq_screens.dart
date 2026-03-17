import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';

class PassportIQProcessingScreen extends StatefulWidget {
  const PassportIQProcessingScreen({super.key});

  @override
  State<PassportIQProcessingScreen> createState() =>
      _PassportIQProcessingScreenState();
}

class _PassportIQProcessingScreenState
    extends State<PassportIQProcessingScreen> {
  double progress = 0.55;

  @override
  void initState() {
    super.initState();
    // Simulate completion
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/candidate/passport/result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined, color: Colors.white, size: 80),
              const SizedBox(height: 32),
              const Text(
                'PassportIQ is verifying your identity',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Securely checking your South African ID against government records...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 48),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation(HireIQTheme.primaryTeal),
              ),
              const SizedBox(height: 12),
              Text('${(progress * 100).toInt()}% complete',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const Spacer(),
              _buildSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(16)),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, color: HireIQTheme.primaryTeal),
              SizedBox(width: 12),
              Text('Bank-grade encryption',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Your ID data is encrypted end-to-end and never stored on HireIQ servers after verification.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          SizedBox(height: 12),
          Text(
            'Verification takes 15–60 seconds',
            style: TextStyle(
                color: HireIQTheme.primaryTeal,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class PassportIQResultScreen extends StatelessWidget {
  const PassportIQResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('PassportIQ Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/candidate/profile'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: HireIQTheme.success, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Identity verified ✓',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your PassportIQ badge is now active on your profile.',
              textAlign: TextAlign.center,
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 40),
            _buildBadgeCard(),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('What your badge unlocks',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
            ),
            const SizedBox(height: 20),
            _buildUnlockItem(
                Icons.star_outline,
                'Priority in employer search results',
                'Verified profiles appear 3× more in shortlists'),
            _buildUnlockItem(Icons.bolt, 'Smart Apply eligibility',
                'Apply instantly without manual ID checks'),
            _buildUnlockItem(
                Icons.verified_user_outlined,
                'ShieldIQ fraud protection',
                'Employers know your identity is confirmed'),
            _buildUnlockItem(Icons.trending_up, 'MatchIQ score boost',
                'Verified candidates receive a +5 MatchIQ bonus'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/candidate/profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Back to Profile',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          HireIQTheme.primaryNavy,
          HireIQTheme.primaryNavy.withAlpha(204)
        ]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: HireIQTheme.primaryNavy.withAlpha(76),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.verified, color: HireIQTheme.amber, size: 64),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PassportIQ Verified',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Thabo Nkosi', style: TextStyle(color: Colors.white)),
              SizedBox(height: 4),
              Text('Verified 8 March 2026',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: HireIQTheme.primaryTeal, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HireIQTheme.textPrimary)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
