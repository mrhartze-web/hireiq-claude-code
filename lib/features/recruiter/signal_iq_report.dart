import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class SignalIQReport extends StatelessWidget {
  const SignalIQReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('SignalIQ Deep Scan'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.accent.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.accent.withAlpha(76)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.insights, color: HireIQTheme.accent),
                      const SizedBox(width: 10),
                      Text(
                        'Q2 2026 Talent Intelligence',
                        style: HireIQTheme.subtitleStyle
                            .copyWith(color: HireIQTheme.accent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Flutter & mobile engineering — Gauteng + Remote SA',
                    style: HireIQTheme.bodyStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text('Supply vs Demand', style: HireIQTheme.subtitleStyle),
            const SizedBox(height: 15),
            _buildMetricCard(
              title: 'Candidate Availability',
              value: 'Low',
              trend: 'Decreasing',
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            _buildMetricCard(
              title: 'Market Competition',
              value: 'High',
              trend: 'Increasing',
              color: Colors.red,
            ),
            const SizedBox(height: 30),
            Text('Salary Benchmarks — Gauteng 2026',
                style: HireIQTheme.subtitleStyle),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Brief:', style: HireIQTheme.bodyStyle),
                      Text('R95K-R120K',
                          style: HireIQTheme.bodyStyle
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Market Average:', style: HireIQTheme.bodyStyle),
                      Text('R135K', style: HireIQTheme.subtitleStyle),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: Colors.orange, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Below market — hiring probability: 34%',
                            style: HireIQTheme.bodyStyle
                                .copyWith(color: Colors.orange, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HireIQTheme.primary,
                    HireIQTheme.primary.withAlpha(204)
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'SignalIQ Recommends:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Increase Head of Engineering salary to R130K minimum and add remote option to compete.',
                    style: TextStyle(color: Colors.white, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: HireIQTheme.primary,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Update Listing Brief'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      {required String title,
      required String value,
      required String trend,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: HireIQTheme.bodyStyle
                      .copyWith(color: HireIQTheme.textSecondary)),
              const SizedBox(height: 5),
              Text(value,
                  style: HireIQTheme.subtitleStyle.copyWith(color: color)),
            ],
          ),
          Text(trend, style: HireIQTheme.bodyStyle.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
