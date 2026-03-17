import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Admin'),
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('System Health',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            _buildStatusItem(
                context, 'Server Status', 'Operational', HireIQTheme.success),
            _buildStatusItem(context, 'Database IQ', 'Synchronized',
                HireIQTheme.primaryTeal),
            _buildStatusItem(
                context, 'AI Processing', 'Queueing (5)', HireIQTheme.warning),
            const SizedBox(height: 32),
            Text('User Overview',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildMetricCard(context, 'Candidates', '12.4k'),
                _buildMetricCard(context, 'Employers', '842'),
                _buildMetricCard(context, 'Recruiters', '156'),
                _buildMetricCard(context, 'New Today', '+42'),
              ],
            ),
            const SizedBox(height: 32),
            Text('Recent Flags', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...List.generate(
                3,
                (index) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.flag_outlined,
                            color: HireIQTheme.error),
                        title: Text('Suspicious Activity #$index'),
                        subtitle: const Text('Automated ShieldIQ detection'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/admin/moderation'),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(
      BuildContext context, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(value,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String label, String value) {
    return Card(
      elevation: 0,
      color: HireIQTheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: HireIQTheme.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.displaySmall),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
