import 'package:cyber_licence/screens/certified/certified.dart';
import 'package:cyber_licence/screens/testing/testing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

class CompletionScreen extends StatefulWidget {
  final String level;

  const CompletionScreen({super.key, required this.level});

  @override
  _CompletionScreenState createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen> {
  @override
  void initState() {
    super.initState();
    _saveProgress();
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is${widget.level}Completed', true);
    await prefs.setBool('is${widget.level}Passed', true);
  }

  String getNextLevel(String currentLevel) {
    switch (currentLevel) {
      case 'Learner':
        return 'Probationary';
      case 'Probationary':
        return 'Full';
      default:
        return 'Full'; // No next level after Full
    }
  }

  @override
  Widget build(BuildContext context) {
    String levelImage;
    switch (widget.level) {
      case 'Learner':
        levelImage = 'assets/image1.png'; // Replace with actual L image
        break;
      case 'Probationary':
        levelImage = 'assets/image2.png'; // Replace with actual P image
        break;
      default:
        levelImage = 'assets/image3.png'; // Replace with actual F image
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Light green
              Color(0xFFC8E6C9), // Slightly darker green
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decorative Confetti Animation
                BounceInDown(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 20, color: Colors.yellow[300]),
                      const SizedBox(width: 8),
                      Icon(Icons.star, size: 20, color: Colors.yellow[300]),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Main Card with Animation
                ZoomIn(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🎉 Congratulations! 🎉',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32), // Dark green
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'You passed the ${widget.level} puzzles!',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          levelImage,
                          width: 150,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.emoji_events,
                            size: 150,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Amazing work! You’re on your way to becoming a cyber safety expert! 🌟',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: const Color(0xFF616161),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Conditional Buttons
                if (widget.level != 'Full') ...[
                  BounceInUp(
                    child: ElevatedButton(
                      onPressed: () {
                        String nextLevel = getNextLevel(widget.level);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestingScreen(level: nextLevel, onPass: (bool passed) {}),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32), // Darker green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        elevation: 8, // Increased elevation for glow effect
                      ),
                      child: Text(
                        'Continue to Next Level',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  BounceInUp(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CertificateDownloadScreen(level: widget.level),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32), // Darker green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        elevation: 8, // Increased elevation for glow effect
                      ),
                      child: Text(
                        'Get My Licence',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
