import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Error404',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: const Text('Web View Content coming soon...'),
            ),
          ],
        ),
      ),
    );
  }
}
