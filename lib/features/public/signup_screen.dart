import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'candidate';
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() => _error = 'Please fill in all fields.');
      return;
    }
    setState(() { _isLoading = true; _error = null; });
    try {
      await ref.read(authServiceProvider).signUpWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _nameController.text.trim(),
        role: _selectedRole,
      );
      if (mounted) context.go('/onboarding');
    } catch (e) {
      setState(() => _error = 'Sign up failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text('Create account',
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              Text('Join HireIQ today',
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: HireIQTheme.textMuted)),
              const SizedBox(height: 40),
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: HireIQTheme.errorLight,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  child: Text(_error!,
                      style: const TextStyle(color: HireIQTheme.error)),
                ),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Text('I am joining as',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _roleOption('candidate', 'Candidate', 'Looking for work'),
              const SizedBox(height: 8),
              _roleOption('employer', 'Employer', 'Hiring talent'),
              const SizedBox(height: 8),
              _roleOption('recruiter', 'Recruiter', 'Placing candidates'),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.primaryNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Create Account',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleOption(String value, String title, String subtitle) {
    final selected = _selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          border: Border.all(
            color: selected
                ? HireIQTheme.primaryNavy
                : HireIQTheme.borderLight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : HireIQTheme.textPrimary)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          color: selected
                              ? Colors.white70
                              : HireIQTheme.textMuted)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
