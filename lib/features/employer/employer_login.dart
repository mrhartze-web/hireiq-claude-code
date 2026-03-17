import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerLogin extends StatelessWidget {
  const EmployerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.business,
                  color: HireIQTheme.primaryTeal, size: 80),
              const SizedBox(height: 24),
              const Text(
                'HireIQ for Employers',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Access top pre-vetted talent.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Work Email',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withAlpha(25),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withAlpha(25),
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: HireIQTheme.primaryTeal)),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/employer-dashboard'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Sign In',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
