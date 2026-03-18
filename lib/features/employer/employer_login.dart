import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
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
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.business,
                    color: HireIQTheme.primaryTeal, size: 44),
              ),
              const SizedBox(height: 24),
              Text(
                'HireIQ for Employers',
                style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Access top pre-vetted talent.',
                style: GoogleFonts.inter(
                    color: Colors.white70, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 56),
              TextField(
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Work Email',
                  hintStyle: GoogleFonts.inter(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.1),
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: GoogleFonts.inter(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.1),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () => context.go('/employer'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        HireIQTheme.primaryTeal,
                        Color(0xFF0A7A70),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.inter(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
