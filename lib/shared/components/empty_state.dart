import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String body;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.heading,
    required this.body,
    this.ctaLabel,
    this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: HireIQTheme.primaryTeal),
            ),
            const SizedBox(height: 24),
            Text(
              heading,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: HireIQTheme.textMuted,
                  ),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCtaPressed != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onCtaPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: HireIQTheme.surfaceWhite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(ctaLabel!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
