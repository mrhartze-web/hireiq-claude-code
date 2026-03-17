import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerInterviewScheduler extends StatelessWidget {
  const EmployerInterviewScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Schedule Interview'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Candidate',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
                  child: const Text('J',
                      style: TextStyle(color: HireIQTheme.primaryTeal)),
                ),
                title: const Text('James K.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                subtitle: const Text('UX Researcher',
                    style: TextStyle(color: HireIQTheme.textMuted)),
                trailing: const Icon(Icons.arrow_drop_down),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Available Time Slots (Your Time)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTimeSlot('Mon, Oct 12', '09:00 - 10:00', true),
                _buildTimeSlot('Mon, Oct 12', '14:00 - 15:00', false),
                _buildTimeSlot('Tue, Oct 13', '10:30 - 11:30', false),
                _buildTimeSlot('Wed, Oct 14', '15:00 - 16:00', false),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Interview Type',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildTypeCard(Icons.videocam, 'Video Call', true)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildTypeCard(Icons.business, 'In Person', false)),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm Schedule',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String date, String time, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? HireIQTheme.primaryNavy : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                selected ? HireIQTheme.primaryNavy : HireIQTheme.borderLight),
      ),
      child: Column(
        children: [
          Text(date,
              style: TextStyle(
                  color: selected ? Colors.white70 : HireIQTheme.textMuted,
                  fontSize: 12)),
          const SizedBox(height: 4),
          Text(time,
              style: TextStyle(
                  color: selected ? Colors.white : HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTypeCard(IconData icon, String title, bool selected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? HireIQTheme.primaryTeal.withAlpha(25) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                selected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon,
              color: selected ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
              size: 32),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  color: selected
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.textMuted,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
