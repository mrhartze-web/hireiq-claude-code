import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class VideoPitchScreen extends StatefulWidget {
  const VideoPitchScreen({super.key});

  @override
  State<VideoPitchScreen> createState() => _VideoPitchScreenState();
}

class _VideoPitchScreenState extends State<VideoPitchScreen> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock Camera Preview
          Center(
            child: Container(
              color: Colors.grey[900],
              child: const Icon(Icons.person, size: 200, color: Colors.white24),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(102),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withAlpha(153),
                  ],
                ),
              ),
            ),
          ),

          // Prompts Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      if (_isRecording)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: HireIQTheme.error,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: Colors.white),
                              SizedBox(width: 8),
                              Text('REC 0:45',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      const SizedBox(width: 48), // Spacer
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(127),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Prompt: What is your biggest accomplishment in your previous role?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text('Keep your eyes on the camera',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => setState(() => _isRecording = !_isRecording),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _isRecording ? HireIQTheme.error : Colors.white,
                        borderRadius:
                            BorderRadius.circular(_isRecording ? 8 : 100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
