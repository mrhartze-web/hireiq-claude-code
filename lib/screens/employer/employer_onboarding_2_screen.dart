import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class EmployerOnboarding2Screen extends StatefulWidget {
  const EmployerOnboarding2Screen({super.key});

  @override
  State<EmployerOnboarding2Screen> createState() =>
      _EmployerOnboarding2ScreenState();
}

class _EmployerOnboarding2ScreenState extends State<EmployerOnboarding2Screen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employer-onboarding-1'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 0.66, // 2/3
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
                '2/3',
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
                  'About your company',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Tell us more about your organization to help us tailor your experience.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 40),

                // Fields
                _buildFieldLabel(context, 'Company Size'),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Select company size',
                    prefixIcon: Icon(Icons.group_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: '1-10', child: Text('1-10 Employees')),
                    DropdownMenuItem(
                        value: '11-50', child: Text('11-50 Employees')),
                    DropdownMenuItem(
                        value: '51-200', child: Text('51-200 Employees')),
                    DropdownMenuItem(
                        value: '201-500', child: Text('201-500 Employees')),
                    DropdownMenuItem(
                        value: '500+', child: Text('500+ Employees')),
                  ],
                  onChanged: (val) {},
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Headquarters'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'City, Country',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Company Bio'),
                TextFormField(
                  maxLines: 4,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: 'Describe your company mission and culture...',
                    fillColor: HireIQColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: HireIQColors.silver),
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Footer Actions
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/employer-onboarding-3');
                    }
                  },
                  child: const Text('Continue'),
                ),
                const SizedBox(height: 32),

                // Legal Footer
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text.rich(
                      TextSpan(
                        text: "By continuing, you agree to our ",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: const [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: HireIQColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
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
