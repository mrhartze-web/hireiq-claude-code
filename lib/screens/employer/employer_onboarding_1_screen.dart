import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class EmployerOnboarding1Screen extends StatefulWidget {
  const EmployerOnboarding1Screen({super.key});

  @override
  State<EmployerOnboarding1Screen> createState() =>
      _EmployerOnboarding1ScreenState();
}

class _EmployerOnboarding1ScreenState extends State<EmployerOnboarding1Screen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 0.33, // 1/3
          backgroundColor: HireIQColors.silver,
          valueColor: AlwaysStoppedAnimation<Color>(HireIQColors.teal),
          minHeight: 6,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '1/3',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: HireIQColors.teal,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Your company',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Tell us a bit about your organization to get started.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 40),

                // Company Logo
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: HireIQColors.silver.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.business_rounded,
                          size: 50,
                          color: HireIQColors.textMuted,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: HireIQColors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Company Logo',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: HireIQColors.textMuted,
                        ),
                  ),
                ),
                const SizedBox(height: 40),

                // Fields
                _buildFieldLabel(context, 'Company Name'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'e.g. Acme Corp',
                    prefixIcon: Icon(Icons.business_outlined),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Please enter company name'
                      : null,
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Company Website'),
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: 'www.example.com',
                    prefixIcon: Icon(Icons.language_outlined),
                  ),
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Industry'),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Select industry',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'tech', child: Text('Technology')),
                    DropdownMenuItem(value: 'finance', child: Text('Finance')),
                    DropdownMenuItem(
                        value: 'healthcare', child: Text('Healthcare')),
                    DropdownMenuItem(
                        value: 'education', child: Text('Education')),
                  ],
                  onChanged: (val) {},
                ),
                const SizedBox(height: 48),

                // Footer Actions
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/employer-onboarding-2');
                    }
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(height: 32),

                // Legal Footer
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text.rich(
                      TextSpan(
                        text: "By clicking \"Next\", you agree to our ",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: const [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: HireIQColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
