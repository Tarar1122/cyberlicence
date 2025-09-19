import 'package:cyber_licence/screens/flashcard/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorksScreen extends StatefulWidget {
  final String name;
  final String avatarPath;

  const HowItWorksScreen({super.key, required this.name, required this.avatarPath});

  @override
  State<HowItWorksScreen> createState() => _HowItWorksScreenState();
}

class _HowItWorksScreenState extends State<HowItWorksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // White background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Heading with decorative dots and stars
              Stack(
                children: [
                  Text(
                    'How CyberLicence Works',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF58CC02), // Green
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Positioned(
                    top: -10,
                    left: 20,
                    child: Icon(Icons.circle, size: 8, color: Colors.green[100]),
                  ),
                  Positioned(
                    top: -5,
                    right: 20,
                    child: Icon(Icons.star, size: 12, color: Colors.yellow[200]),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 40,
                    child: Icon(Icons.circle, size: 6, color: Colors.green[100]),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Steps with Icons
              Expanded(
                child: ListView(
                  children: [
                    _buildStepWithIcon(
                      Icons.card_giftcard,
                      'Learn from the flashcards',
                      'Study fun cards to learn about cyber safety.',
                    ),
                    _buildStepWithIcon(
                      Icons.edit,
                      'Attempt the quiz',
                      'Answer questions to test what you learned.',
                    ),
                    _buildStepWithIcon(
                      Icons.tablet,
                      'Move from Learner (L) → Probationary (P) → Full (F)',
                      'Pass with 90% or more to progress.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Visual Flow (L, P, F as road signs)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLevelIndicator('L', const Color(0xFFFFC200)), // Yellow
                    const Icon(Icons.arrow_forward, color: Color(0xFF212121)),
                    _buildLevelIndicator('P', const Color(0xFFE57373)), // Soft Red
                    const Icon(Icons.arrow_forward, color: Color(0xFF212121)),
                    _buildLevelIndicator('F', const Color(0xFF58CC02)), // Green
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Flashcards Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FlashcardsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02), // Green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  'Let’s Drive Safely Online',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepWithIcon(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8), // Light Grey card background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF58CC02), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121), // Dark Grey
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: const Color(0xFF616161), // Medium Grey
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelIndicator(String level, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF212121)),
      ),
      child: Text(
        level,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF212121), // Dark Grey
        ),
      ),
    );
  }
}
