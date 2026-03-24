import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/web_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(),
          _BodySection(),
        ],
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              Text(
                'Get in Touch',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'We would love to hear from you. Whether you are a candidate, employer, recruiter, or investor — we are here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.65,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _BodySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 820;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _ContactForm()),
                  const SizedBox(width: 56),
                  Expanded(flex: 2, child: _SidePanel()),
                ],
              );
            }
            return Column(
              children: [
                _ContactForm(),
                const SizedBox(height: 48),
                _SidePanel(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Contact form ──────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _role = 'Candidate';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _send() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Message sent — we will be in touch within 2 business hours'),
        backgroundColor: HireIQTheme.primaryTeal,
      ),
    );
    _nameCtrl.clear();
    _emailCtrl.clear();
    _subjectCtrl.clear();
    _messageCtrl.clear();
    setState(() => _role = 'Candidate');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a Message',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 28),
            _label('Full Name'),
            TextFormField(
              controller: _nameCtrl,
              style: _textStyle,
              decoration: _deco('Your full name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Name is required'
                  : null,
            ),
            const SizedBox(height: 20),
            _label('Email Address'),
            TextFormField(
              controller: _emailCtrl,
              style: _textStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: _deco('you@example.com'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 20),
            _label('I am a'),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: _deco(''),
              style: _textStyle,
              items: const [
                'Candidate',
                'Employer',
                'Recruiter',
                'Investor',
                'Press',
                'Other',
              ]
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (v) => setState(() => _role = v!),
            ),
            const SizedBox(height: 20),
            _label('Subject'),
            TextFormField(
              controller: _subjectCtrl,
              style: _textStyle,
              decoration: _deco('What is this about?'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Subject is required'
                  : null,
            ),
            const SizedBox(height: 20),
            _label('Message'),
            TextFormField(
              controller: _messageCtrl,
              style: _textStyle,
              maxLines: 6,
              decoration: _deco('Tell us more...'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Message is required'
                  : null,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _send,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
                child: Text('Send Message',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _textStyle =>
      GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary);

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.textPrimary)),
      );

  InputDecoration _deco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
        filled: true,
        fillColor: HireIQTheme.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: HireIQTheme.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: HireIQTheme.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide:
              const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: HireIQTheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: HireIQTheme.error),
        ),
      );
}

// ── Side panel ────────────────────────────────────────────────────────────────

class _SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactDetailsCard(),
        const SizedBox(height: 24),
        _AudienceCard(
          icon: Icons.business_outlined,
          title: 'For Employers',
          body: 'Book a demo to see HireIQ in action.',
          buttonLabel: 'Book a Demo',
          isPrimary: true,
          onPressed: () => context.go('/signup'),
        ),
        const SizedBox(height: 16),
        _AudienceCard(
          icon: Icons.show_chart_rounded,
          title: 'For Investors',
          body: 'Request our full pitch deck and financials.',
          buttonLabel: 'Request Deck',
          isPrimary: false,
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('We will send our investor pack to your email'),
              backgroundColor: HireIQTheme.primaryNavy,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _AudienceCard(
          icon: Icons.newspaper_outlined,
          title: 'For Press',
          body: 'Download our media kit and brand assets.',
          buttonLabel: 'Download Kit',
          isPrimary: false,
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Media kit coming soon — email hello@hireiq.co.za'),
              backgroundColor: HireIQTheme.primaryNavy,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Details',
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const SizedBox(height: 20),
          _row(Icons.email_outlined, 'hello@hireiq.co.za'),
          const SizedBox(height: 12),
          _row(Icons.schedule_outlined, 'Within 2 business hours'),
          const SizedBox(height: 12),
          _row(Icons.location_on_outlined, 'Johannesburg, South Africa'),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) => Row(children: [
        Icon(icon, size: 16, color: HireIQTheme.primaryTeal),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.8))),
        ),
      ]);
}

class _AudienceCard extends StatelessWidget {
  const _AudienceCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.isPrimary,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String body;
  final String buttonLabel;
  final bool isPrimary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child:
                  Icon(icon, size: 18, color: HireIQTheme.primaryTeal),
            ),
            const SizedBox(width: 12),
            Text(title,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy)),
          ]),
          const SizedBox(height: 10),
          Text(body,
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: HireIQTheme.textSecondary,
                  height: 1.5)),
          const SizedBox(height: 14),
          isPrimary
              ? ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.primaryTeal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull)),
                  ),
                  child: Text(buttonLabel,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                )
              : OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HireIQTheme.primaryNavy,
                    side: const BorderSide(
                        color: HireIQTheme.primaryNavy, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusFull)),
                  ),
                  child: Text(buttonLabel,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                ),
        ],
      ),
    );
  }
}
