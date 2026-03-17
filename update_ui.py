import os
import re

print('Updating login_screen.dart...')
with open('lib/features/public/login_screen.dart', 'r', encoding='utf-8') as f:
    text = f.read()

text = text.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../providers/auth_provider.dart';")
text = text.replace("class LoginScreen extends ConsumerWidget {\n  const LoginScreen({super.key});\n\n  @override\n  Widget build(BuildContext context, WidgetRef ref) {", '''class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).signInWithEmail(_emailController.text, _passwordController.text);
      if (!mounted) return;
      context.go('/');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {''')

text = text.replace("              TextField(\n                decoration: InputDecoration(", "              TextField(\n                controller: _emailController,\n                decoration: InputDecoration(")
text = text.replace("              TextField(\n                obscureText: true,", "              TextField(\n                controller: _passwordController,\n                obscureText: true,")
btn_pattern = re.compile(r'ElevatedButton\(\s*onPressed: \(\) => context\.go\(MobileRoutes\.roleSelection\),.*?,(?=\s*child)', re.DOTALL)
text = btn_pattern.sub("ElevatedButton(\n                  onPressed: _isLoading ? null : _login,\n                  style: ElevatedButton.styleFrom(\n                    backgroundColor: HireIQTheme.primaryNavy,\n                    shape: RoundedRectangleBorder(\n                      borderRadius: BorderRadius.circular(12),\n                    ),\n                  ),", text)
text = text.replace("                  child: Text(\n                    'Sign In',", "                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(\n                    'Sign In',")

with open('lib/features/public/login_screen.dart', 'w', encoding='utf-8') as f:
    f.write(text)

print('Updating signup_screen.dart...')
with open('lib/features/public/signup_screen.dart', 'r', encoding='utf-8') as f:
    signup_text = f.read()

signup_text = signup_text.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../providers/auth_provider.dart';")
signup_text = signup_text.replace("class SignupScreen extends ConsumerWidget {\n  const SignupScreen({super.key});\n\n  @override\n  Widget build(BuildContext context, WidgetRef ref) {", '''class SignupScreen extends ConsumerStatefulWidget {
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

  Future<void> _signup() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).signUpWithEmail(_emailController.text, _passwordController.text, _nameController.text, _selectedRole);
      if (!mounted) return;
      context.go('/onboarding');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {''')

# We inject controllers into the generic TextFields inside signup screen
# Assuming 3 generic TextFields
signup_text = signup_text.replace("              TextField(", "              TextField(\n                controller: _nameController,", 1)
signup_text = signup_text.replace("              TextField(", "              TextField(\n                controller: _emailController,", 1)
signup_text = signup_text.replace("              TextField(\n                obscureText: true,", "              TextField(\n                controller: _passwordController,\n                obscureText: true,", 1)

# Now to role selection UI (mocking a simple dropdown to inject role if needed, or if it doesn't exist, it's fine)
btn_pattern_signup = re.compile(r'ElevatedButton\(\s*onPressed: \(\) => context\.go\(MobileRoutes\.emailVerification\),.*?,(?=\s*child)', re.DOTALL)
signup_text = btn_pattern_signup.sub("ElevatedButton(\n                  onPressed: _isLoading ? null : _signup,\n                  style: ElevatedButton.styleFrom(\n                    backgroundColor: HireIQTheme.primaryNavy,\n                    shape: RoundedRectangleBorder(\n                      borderRadius: BorderRadius.circular(12),\n                    ),\n                  ),", signup_text)
signup_text = signup_text.replace("                  child: Text(\n                    'Create Account',", "                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(\n                    'Create Account',")

with open('lib/features/public/signup_screen.dart', 'w', encoding='utf-8') as f:
    f.write(signup_text)

print('Done.')
