import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigReviewScreen extends ConsumerStatefulWidget {
  const GigReviewScreen({super.key});

  @override
  ConsumerState<GigReviewScreen> createState() => _GigReviewScreenState();
}

class _GigReviewScreenState extends ConsumerState<GigReviewScreen> {
  int _rating = 0;
  final Set<String> _tags = {};
  final TextEditingController _review = TextEditingController();

  static const List<String> _availableTags = [
    'Professional',
    'Fast payment',
    'Clear communication',
    'Would work again',
    'Exceeded expectations',
    'Recommended',
  ];

  @override
  void dispose() {
    _review.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: HireIQTheme.primaryNavy),
        title: Text(
          'Leave a Review',
          style: GoogleFonts.inter(
            color: HireIQTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate your experience',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Text(
                'FinCorp SA · Mobile App Development',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Star rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = i + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      i < _rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: 40,
                      color: HireIQTheme.amber,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            Text(
              'Add a review',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _review,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Share your experience',
                hintText: 'How was it working with this client?',
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
              ),
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Tags',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTags.map((tag) {
                final selected = _tags.contains(tag);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _tags.remove(tag);
                      } else {
                        _tags.add(tag);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? HireIQTheme.amber.withValues(alpha: 0.1)
                          : Colors.white,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                      border: Border.all(
                        color: selected
                            ? HireIQTheme.amber
                            : HireIQTheme.borderLight,
                      ),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(
                        color: selected
                            ? HireIQTheme.amber
                            : HireIQTheme.textMuted,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a rating'),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Review submitted. Thank you!'),
                    ),
                  );
                  context.go('/candidate/gig-feed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                ),
                child: Text(
                  'Submit Review',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () => context.go('/candidate/gig-feed'),
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.inter(color: HireIQTheme.textMuted),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
