import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({super.key});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int _rating = 0;
  bool _wouldHireAgain = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Leave a Review'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildCandidateProfile(),
            const SizedBox(height: 40),
            Text('How was your experience?', style: HireIQTheme.subtitleStyle),
            const SizedBox(height: 20),
            _buildStarRating(),
            const SizedBox(height: 10),
            Text(
              _getRatingText(),
              style: const TextStyle(
                  color: HireIQTheme.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildHireAgainSection(),
            const SizedBox(height: 40),
            _buildReviewField(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: HireIQTheme.primary.withAlpha(25),
          child: const Text('TN',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primary)),
        ),
        const SizedBox(height: 15),
        Text('Thabo Nkosi', style: HireIQTheme.subtitleStyle),
        Text('Flutter Developer',
            style: HireIQTheme.bodyStyle
                .copyWith(color: HireIQTheme.textSecondary)),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
            color: index < _rating ? Colors.amber : Colors.grey[400],
            size: 48,
          ),
        );
      }),
    );
  }

  String _getRatingText() {
    switch (_rating) {
      case 1:
        return 'Needs improvement';
      case 2:
        return 'Below expectations';
      case 3:
        return 'Met expectations';
      case 4:
        return 'Above average';
      case 5:
        return 'Outstanding';
      default:
        return 'Select rating';
    }
  }

  Widget _buildHireAgainSection() {
    return Column(
      children: [
        const Text('Would you hire Thabo again?',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoiceChip('Yes, absolutely', true, _wouldHireAgain),
            const SizedBox(width: 15),
            _buildChoiceChip('Maybe, not sure', false, !_wouldHireAgain),
          ],
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool value, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _wouldHireAgain = value;
        });
      },
      selectedColor: HireIQTheme.primary.withAlpha(51),
      labelStyle: TextStyle(
        color: isSelected ? HireIQTheme.primary : HireIQTheme.textSecondary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildReviewField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detailed feedback (optional)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Share more details about working with Thabo...',
            filled: true,
            fillColor: HireIQTheme.surface,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
