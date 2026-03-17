import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerInterviewScheduler extends StatelessWidget {
  const EmployerInterviewScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Schedule Interview',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Candidate',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                        child: Text(
                          'J',
                          style: GoogleFonts.inter(
                              color: HireIQTheme.primaryTeal,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      title: Text(
                        'James K.',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryNavy),
                      ),
                      subtitle: Text(
                        'UX Researcher',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted, fontSize: 13),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down,
                          color: HireIQTheme.textMuted),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Available Time Slots (Your Time)',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTimeSlot(
                          'Mon, Oct 12', '09:00 - 10:00', true),
                      _buildTimeSlot(
                          'Mon, Oct 12', '14:00 - 15:00', false),
                      _buildTimeSlot(
                          'Tue, Oct 13', '10:30 - 11:30', false),
                      _buildTimeSlot(
                          'Wed, Oct 14', '15:00 - 16:00', false),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Interview Type',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTypeCard(
                              Icons.videocam, 'Video Call', true)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildTypeCard(
                              Icons.business, 'In Person', false)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {},
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
                        'Confirm Schedule',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String date, String time, bool selected) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(
          color: selected
              ? HireIQTheme.primaryNavy
              : HireIQTheme.borderLight,
        ),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: GoogleFonts.inter(
                color: selected
                    ? Colors.white60
                    : HireIQTheme.textMuted,
                fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: GoogleFonts.inter(
                color: selected ? Colors.white : HireIQTheme.primaryNavy,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(IconData icon, String title, bool selected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected
            ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(
          color: selected
              ? HireIQTheme.primaryTeal
              : HireIQTheme.borderLight,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: selected
                ? HireIQTheme.primaryTeal
                : HireIQTheme.textMuted,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
                color: selected
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.textMuted,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
