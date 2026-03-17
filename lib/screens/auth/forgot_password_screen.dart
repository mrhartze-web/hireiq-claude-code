import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Reset password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Brand Header (matching other screens)
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

                // Recovery Header
                Text(
                  'Reset your password',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Enter your email and we'll send you a reset link to your inbox.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 48),

                // Email Field
                Text(
                  'Email Address',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'name@company.com',
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!val.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Action Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform password reset logic
                      context.go('/login');
                    }
                  },
                  child: const Text('Send Reset Link'),
                ),
                const SizedBox(height: 32),

                // Back to SignIn Footer
                Center(
                  child: TextButton.icon(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Icons.chevron_left, size: 20),
                    label: const Text('Back to Sign in'),
                    style: TextButton.styleFrom(
                      foregroundColor: HireIQColors.textMuted,
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
}
