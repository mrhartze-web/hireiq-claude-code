import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Brand Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: HireIQColors.navy,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.psychology_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'HireIQ',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                                color: HireIQColors.navy,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Welcome Header
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 40),

                // Full Name Field
                Text(
                  'Full Name',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (val) => (val == null || val.isEmpty)
                      ? 'Please enter your full name'
                      : null,
                ),
                const SizedBox(height: 24),

                // Email Field
                Text(
                  'Email address',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'name@company.com',
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                  validator: (val) => (val == null || !val.contains('@'))
                      ? 'Please enter a valid email'
                      : null,
                ),
                const SizedBox(height: 24),

                // Password Field
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _obscurePassword,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (val) => (val == null || val.length < 8)
                      ? 'Password must be at least 8 characters'
                      : null,
                ),
                const SizedBox(height: 24),

                // Terms of Service Checkbox
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _termsAccepted,
                        onChanged: (val) =>
                            setState(() => _termsAccepted = val ?? false),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to the ',
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const [
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                  color: HireIQColors.teal,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  color: HireIQColors.teal,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Sign Up Button
                ElevatedButton(
                  onPressed: !_termsAccepted
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            // Perform account creation
                            context.go('/role-selection');
                          }
                        },
                  child: const Text('Create Account'),
                ),
                const SizedBox(height: 48),

                // Footer
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HireIQColors.textMuted,
                            ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
