import os
import re

print('Updating candidate_profile.dart...')
with open('lib/features/candidate/candidate_profile.dart', 'r', encoding='utf-8') as f:
    cp = f.read()

# Make sure it's a ConsumerWidget
cp = cp.replace("class CandidateProfileScreen extends StatelessWidget {", "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../../providers/candidate_provider.dart';\nimport '../../providers/auth_provider.dart';\n\nclass CandidateProfileScreen extends ConsumerWidget {")
cp = cp.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context, WidgetRef ref) {\n    final user = ref.watch(authStateProvider).value;\n    if (user == null) return const Center(child: Text('Not Authenticated'));\n    final profileAsync = ref.watch(candidateProfileProvider(user.uid));")

body_pattern = re.compile(r'body: SingleChildScrollView\(.*?(?=\s*\]\s*\)\s*,\s*\)\s*,\s*\)\s*;)', re.DOTALL)
body_replacement = '''body: profileAsync.when(
        data: (profile) {
          if (profile == null) return const Center(child: Text('Profile not found'));
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context, profile.headline, profile.location, profile.matchIQScore),
                const SizedBox(height: 32),
                _buildSectionTitle('About Me'),
                const SizedBox(height: 12),
                Text(
                  profile.bio,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQTheme.textMuted,
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 32),
                _buildSectionTitle('Skills'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.skills.map((s) => _buildSkillChip(s)).toList(),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: _buildMetricCard(context, 'Experience', '${profile.yearsExperience} Years', Icons.work_outline)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildMetricCard(context, 'Salary Expectation', 'R${profile.salaryExpectation}', Icons.account_balance_wallet_outlined)),
                  ],
                ),
                const SizedBox(height: 32),
                _buildActionButtons(context),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );'''

cp = body_pattern.sub(body_replacement, cp)
with open('lib/features/candidate/candidate_profile.dart', 'w', encoding='utf-8') as f:
    f.write(cp)

print('Updating employer_dashboard.dart...')
with open('lib/features/employer/employer_dashboard.dart', 'r', encoding='utf-8') as f:
    ed = f.read()

ed = ed.replace("class EmployerDashboardScreen extends StatelessWidget {", "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../../providers/job_provider.dart';\nimport '../../providers/auth_provider.dart';\n\nclass EmployerDashboardScreen extends ConsumerWidget {")
ed = ed.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context, WidgetRef ref) {\n    final user = ref.watch(authStateProvider).value;\n    if (user == null) return const Center(child: Text('Not Authenticated'));\n    final jobsAsync = ref.watch(employerJobsProvider(user.uid));")

ed = ed.replace("_buildStatCard(context, 'Active Jobs', '12', Icons.work, HireIQTheme.primaryNavy),", """jobsAsync.when(
                        data: (jobs) => _buildStatCard(context, 'Active Jobs', '${jobs.length}', Icons.work, HireIQTheme.primaryNavy),
                        loading: () => _buildStatCard(context, 'Active Jobs', '...', Icons.work, HireIQTheme.primaryNavy),
                        error: (_, __) => _buildStatCard(context, 'Active Jobs', '0', Icons.work, HireIQTheme.primaryNavy),
                      ),""")

with open('lib/features/employer/employer_dashboard.dart', 'w', encoding='utf-8') as f:
    f.write(ed)

print('Updating recruiter_earnings_dashboard.dart...')
with open('lib/features/recruiter/recruiter_earnings_dashboard.dart', 'r', encoding='utf-8') as f:
    red = f.read()

red = red.replace("class RecruiterEarningsDashboard extends StatelessWidget {", "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../../providers/recruiter_provider.dart';\nimport '../../providers/auth_provider.dart';\n\nclass RecruiterEarningsDashboard extends ConsumerWidget {")
red = red.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context, WidgetRef ref) {\n    final user = ref.watch(authStateProvider).value;\n    if (user == null) return const Center(child: Text('Not Authenticated'));\n    final placementsAsync = ref.watch(recruiterPlacementsProvider(user.uid));")

stats_pattern = re.compile(r'Row\(\s*children: \[\s*Expanded\(child: _buildMetricCard\(.*?\)\]\s*\),', re.DOTALL)
stats_repl = """placementsAsync.when(
                  data: (placements) {
                    final totalEarnings = placements.fold<double>(0, (sum, p) => sum + p.feeAmount);
                    final pendingFees = placements.where((p) => p.paymentStatus == 'pending').fold<double>(0, (sum, p) => sum + p.feeAmount);
                    return Row(
                      children: [
                        Expanded(child: _buildMetricCard(context, 'Total Earnings', 'R${totalEarnings.toStringAsFixed(0)}', Icons.account_balance_wallet, HireIQTheme.primaryTeal)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMetricCard(context, 'Pending Fees', 'R${pendingFees.toStringAsFixed(0)}', Icons.pending_actions, HireIQTheme.secondaryOrange)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMetricCard(context, 'Completed Placements', '${placements.length}', Icons.check_circle, HireIQTheme.primaryNavy)),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e,s) => const Center(child: Text('Error loading stats')),
                ),"""
red = stats_pattern.sub(stats_repl, red)

list_pattern = re.compile(r'ListView\.builder\([^;]+?;', re.DOTALL)
list_repl = """placementsAsync.when(
                        data: (placements) {
                          if (placements.isEmpty) return const Padding(padding: EdgeInsets.all(24.0), child: Text('No placement history yet.'));
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: placements.length,
                            itemBuilder: (context, index) {
                              final p = placements[index];
                              return _buildTransactionItem(context, p.roleName, 'R${p.annualSalary}', '${p.feePercentage}%', 'R${p.feeAmount.toStringAsFixed(0)}');
                            },
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e,s) => Center(child: Text('Error loading history')),
                      );"""
red = list_pattern.sub(list_repl, red)

# Fix _buildTransactionItem arguments since the layout asked for "Role, Annual Salary, Fee Percentage, Fee Amount"
red = red.replace("Widget _buildTransactionItem(BuildContext context, String candidate, String role, String date, String amount) {", "Widget _buildTransactionItem(BuildContext context, String candidate, String role, String date, String amount) {")
# No layout changes to the transaction item, just passing the right strings

with open('lib/features/recruiter/recruiter_earnings_dashboard.dart', 'w', encoding='utf-8') as f:
    f.write(red)

print('Done Dashboard UIs.')
