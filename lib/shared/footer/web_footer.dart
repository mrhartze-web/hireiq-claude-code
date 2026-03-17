import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column 1: Brand & Contact
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.work_outline,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'HireIQ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'AI-powered talent matching for Africa\'s top tech engineering professionals.',
                      style: TextStyle(
                          color: Colors.white.withAlpha(178),
                          fontSize: 14,
                          height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'hello@hireiq.co.za',
                      style: TextStyle(
                          color: HireIQTheme.primaryTeal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),

              // Column 2: Candidates
              Expanded(
                child: _buildFooterLinkGroup(context, 'For Candidates', [
                  ('Job Search', '/web/candidate/job-search'),
                  ('Create Profile', '/web/candidate/profile'),
                  ('Salary Guide', '/web/candidate/salary-guide'),
                  ('Career Tools', '/web/candidate/career-goals'),
                ]),
              ),

              // Column 3: Employers
              Expanded(
                child: _buildFooterLinkGroup(context, 'For Employers', [
                  ('Post a Job', '/web/employer/post-job'),
                  ('Pricing', '/pricing'),
                  ('Talent Search', '/web/employer/candidate-search'),
                  ('Analytics', '/web/employer/analytics'),
                ]),
              ),

              // Column 4: Company
              Expanded(
                child: _buildFooterLinkGroup(context, 'Company', [
                  ('About Us', '/about'),
                  ('Careers', '/contact'),
                  ('Blog', '/blog'),
                  ('Thundafund', '/thundafund'),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: Colors.white.withAlpha(51)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 HireIQ Technologies. All rights reserved.',
                style:
                    TextStyle(color: Colors.white.withAlpha(127), fontSize: 12),
              ),
              Row(
                children: [
                  _buildBottomTextLink('Privacy Policy'),
                  const SizedBox(width: 20),
                  _buildBottomTextLink('Terms of Service'),
                  const SizedBox(width: 20),
                  _buildBottomTextLink('System Status'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFooterLinkGroup(
      BuildContext context, String title, List<(String, String)> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.go(link.$2),
                  child: Text(
                    link.$1,
                    style: TextStyle(
                        color: Colors.white.withAlpha(178), fontSize: 14),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildBottomTextLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white.withAlpha(127), fontSize: 12),
        ),
      ),
    );
  }
}
