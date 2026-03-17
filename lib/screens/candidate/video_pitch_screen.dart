import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class VideoPitchScreen extends StatelessWidget {
  const VideoPitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildCameraPreview(),
          _buildOverlays(context),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[900],
      child: const Center(
        child:
            Icon(Icons.camera_front_rounded, size: 80, color: Colors.white24),
      ),
    );
  }

  Widget _buildOverlays(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => context.go('/candidate-profile'),
                    icon: const Icon(Icons.close_rounded, color: Colors.white)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('REC 0:24',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.flip_camera_ios_rounded,
                        color: Colors.white)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87]),
            ),
            child: Column(
              children: [
                const Text('Pitch Prompt:',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Tell us about your most challenging technical architect role and how you handled scaling issues.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                _buildRecordButton(),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => context.go('/candidate-profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQColors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save to Profile'),
                ),
                const SizedBox(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome_rounded,
                        color: HireIQColors.teal, size: 16),
                    SizedBox(width: 8),
                    Text('Auto-captioning enabled',
                        style: TextStyle(color: Colors.white54, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordButton() {
    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4)),
      child: Container(
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
    );
  }
}
