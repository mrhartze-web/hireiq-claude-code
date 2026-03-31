import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../shared/theme.dart';
import '../../services/firebase/firestore_service.dart';

enum _VerifyStep { enterPhone, enterOtp }

class RecruiterOnboardingPhoneVerify extends ConsumerStatefulWidget {
  const RecruiterOnboardingPhoneVerify({super.key});

  @override
  ConsumerState<RecruiterOnboardingPhoneVerify> createState() =>
      _RecruiterOnboardingPhoneVerifyState();
}

class _RecruiterOnboardingPhoneVerifyState
    extends ConsumerState<RecruiterOnboardingPhoneVerify> {
  _VerifyStep _step = _VerifyStep.enterPhone;
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String _verificationId = '';
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  String _normalizePhone(String input) {
    final cleaned = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.startsWith('0') && cleaned.length == 10) {
      return '+27${cleaned.substring(1)}';
    }
    if (cleaned.startsWith('27') && cleaned.length == 11) {
      return '+$cleaned';
    }
    return cleaned;
  }

  bool _isValidSAMobile(String normalized) =>
      RegExp(r'^\+27[6-8]\d{8}$').hasMatch(normalized);

  String _hashPhone(String normalized) =>
      sha256.convert(utf8.encode(normalized)).toString();

  Future<void> _sendOtp() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final normalized = _normalizePhone(_phoneController.text.trim());
      if (!_isValidSAMobile(normalized)) {
        setState(() {
          _error = 'Enter a valid South African mobile number (e.g. 082 123 4567).';
          _loading = false;
        });
        return;
      }

      final hash = _hashPhone(normalized);
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final exists =
          await FirestoreService().checkPhoneHashExists(hash, excludeUid: uid);
      if (exists) {
        setState(() {
          _error =
              'This number is already registered to an account. Contact hello@hireiq.co.za for assistance.';
          _loading = false;
        });
        return;
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: normalized,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _linkCredential(credential, normalized);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _error = e.message ?? 'Verification failed. Please try again.';
            _loading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _step = _VerifyStep.enterOtp;
            _loading = false;
          });
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      setState(() {
        _error = 'Something went wrong. Please try again.';
        _loading = false;
      });
    }
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text.trim(),
      );
      await _linkCredential(
          credential, _normalizePhone(_phoneController.text.trim()));
    } catch (e) {
      setState(() {
        _error = 'Invalid code. Please check and try again.';
        _loading = false;
      });
    }
  }

  Future<void> _linkCredential(
      PhoneAuthCredential credential, String normalizedPhone) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      try {
        await user.linkWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code != 'provider-already-linked') rethrow;
      }

      final hash = _hashPhone(normalizedPhone);
      await FirestoreService().storePhoneVerification(
        uid: user.uid,
        phoneHash: hash,
        verifiedAt: DateTime.now(),
        emailVerified: user.emailVerified,
      );

      if (mounted) context.go('/recruiter/onboarding/step-2');
    } catch (e) {
      setState(() {
        _error = 'Verification failed. Please try again.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Verify Your Number',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: HireIQTheme.borderLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Step 2 of 4',
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_outlined,
                      color: HireIQTheme.primaryTeal, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Phone verification protects your account and enables your first placement fee waiver.',
                      style: GoogleFonts.inter(
                          fontSize: 13, color: HireIQTheme.primaryTeal),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            if (_step == _VerifyStep.enterPhone) ...[
              Text(
                'Your mobile number',
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your South African mobile number. We'll send a one-time code.",
                style:
                    GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                  hintText: '082 123 4567',
                  labelStyle: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 14),
                  prefixIcon: const Icon(Icons.phone_outlined,
                      color: HireIQTheme.textMuted),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.primaryTeal),
                  ),
                ),
              ),
            ] else ...[
              Text(
                'Enter your OTP',
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A 6-digit code was sent to ${_phoneController.text.trim()}',
                style:
                    GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: '6-digit code',
                  labelStyle: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: HireIQTheme.textMuted),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide:
                        const BorderSide(color: HireIQTheme.primaryTeal),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loading
                    ? null
                    : () => setState(() {
                          _step = _VerifyStep.enterPhone;
                          _otpController.clear();
                          _error = null;
                        }),
                child: Text(
                  '← Change number',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal, fontSize: 14),
                ),
              ),
            ],

            if (_error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: HireIQTheme.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  border: Border.all(
                      color: HireIQTheme.error.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error_outline,
                        color: HireIQTheme.error, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: GoogleFonts.inter(
                            color: HireIQTheme.error, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                onPressed: _loading
                    ? null
                    : (_step == _VerifyStep.enterPhone
                        ? _sendOtp
                        : _verifyOtp),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HireIQTheme.primaryNavy),
                        ),
                      )
                    : Text(
                        _step == _VerifyStep.enterPhone
                            ? 'Send Code'
                            : 'Verify & Continue',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Text(
                'Your number is used for account security only and will never be shared.',
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
