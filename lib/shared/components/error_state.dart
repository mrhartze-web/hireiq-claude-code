import 'package:flutter/material.dart';
import '../theme.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(HireIQTheme.spacingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 48, color: HireIQTheme.error),
            const SizedBox(height: HireIQTheme.spacingMd),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: HireIQTheme.textMuted, fontSize: 14)),
            if (onRetry != null) ...[
              const SizedBox(height: HireIQTheme.spacingMd),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
