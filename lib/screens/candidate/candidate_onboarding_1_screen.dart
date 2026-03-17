import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateOnboarding1Screen extends StatefulWidget {
  const CandidateOnboarding1Screen({super.key});

  @override
  State<CandidateOnboarding1Screen> createState() =>
      _CandidateOnboarding1ScreenState();
}

class _CandidateOnboarding1ScreenState
    extends State<CandidateOnboarding1Screen> {
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
          value: 0.2, // 1/5
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
                '1/5',
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
                  'Tell us about you',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We'll use this information to personalize your job search experience.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 40),

                // Profile Photo
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: HireIQColors.silver.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
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
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Fields
                _buildFieldLabel(context, 'Date of Birth'),
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Select your birth date',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  onTap: () {
                    // Show Date Picker
                  },
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Location'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'City, Country',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                const SizedBox(height: 24),

                _buildFieldLabel(context, 'Phone Number'),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: '+1 (555) 000-0000',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 48),

                // Footer Actions
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/candidate-onboarding-2');
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
                        text: "By continuing, you agree to HireIQ's ",
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
