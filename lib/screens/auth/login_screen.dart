import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
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
                  'Welcome back',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: HireIQColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: HireIQColors.textMuted,
                      ),
                ),
                const SizedBox(height: 40),

                // Form Fields
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
                  validator: (val) => (val == null || val.length < 6)
                      ? 'Password is too short'
                      : null,
                ),
                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.go('/forgot-password'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 32),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform login
                      context.go('/role-selection');
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 48),

                // Social Login Placeholder
                Center(
                  child: Text(
                    'Or sign in with',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: HireIQColors.textMuted,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.g_mobiledata_rounded, size: 28),
                        label: const Text('Google'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.work_outline_rounded, size: 20),
                        label: const Text('LinkedIn'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Sign Up Footer
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HireIQColors.textMuted,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          // context.push('/signup');
                          context.go('/signup');
                        },
                        child: const Text('Create one'),
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
