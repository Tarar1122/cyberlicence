import 'package:cyber_licence/screens/testing/testing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
// import 'testing_screen.dart';

// Flashcard data (20 cards per level)
final Map<String, List<Map<String, String>>> flashcards = {
  'Learner': [
    {'question': 'What is a strong password?', 'answer': 'A mix of letters, numbers, and symbols.'},
    {'question': 'Why avoid sharing personal info?', 'answer': 'To stay safe from strangers online.'},
    {'question': 'What is a safe website?', 'answer': 'One with "https" and a lock icon.'},
    {'question': 'What should you do if you see a pop-up ad?', 'answer': 'Close it and don’t click.'},
    {'question': 'Why use a nickname online?', 'answer': 'To keep your real name private.'},
    {'question': 'What is cyberbullying?', 'answer': 'Being mean to someone online.'},
    {'question': 'Who can you tell if someone is mean online?', 'answer': 'A trusted adult, like a parent or teacher.'},
    {'question': 'What is a virus in computers?', 'answer': 'Bad software that harms your device.'},
    {'question': 'Why not click on unknown links?', 'answer': 'They might have viruses or scams.'},
    {'question': 'What is a private message?', 'answer': 'A message only you and the sender see.'},
    {'question': 'Why keep your address secret?', 'answer': 'To stop strangers from finding you.'},
    {'question': 'What is a trusted adult?', 'answer': 'Someone like a parent or teacher you can tell things to.'},
    {'question': 'Why not share your password?', 'answer': 'Someone might use it to pretend to be you.'},
    {'question': 'What is a safe app?', 'answer': 'One approved by your parents or teacher.'},
    {'question': 'Why check with parents before downloading?', 'answer': 'To make sure it’s safe and okay.'},
    {'question': 'What is a public Wi-Fi?', 'answer': 'Free internet in places like cafes.'},
    {'question': 'Why avoid public Wi-Fi for personal stuff?', 'answer': 'It’s not always safe from hackers.'},
    {'question': 'What does "log out" mean?', 'answer': 'Closing your account so others can’t use it.'},
    {'question': 'Why not talk to strangers online?', 'answer': 'They might not be who they say they are.'},
    {'question': 'What is a good internet rule?', 'answer': 'Be kind and respectful to others.'},
  ],
  'Probationary': [
    {'question': 'What is phishing?', 'answer': 'Tricking you to share personal info.'},
    {'question': 'What is a firewall?', 'answer': 'It protects your device from hackers.'},
    {'question': 'What is a scam email?', 'answer': 'An email trying to trick you for money or info.'},
    {'question': 'Why use antivirus software?', 'answer': 'To protect your device from viruses.'},
    {'question': 'What is a secure connection?', 'answer': 'A safe way to connect to the internet.'},
    {'question': 'What is a fake website?', 'answer': 'A site that looks real but steals your info.'},
    {'question': 'Why not open unknown emails?', 'answer': 'They might have viruses or scams.'},
    {'question': 'What is a privacy setting?', 'answer': 'Controls who sees your online info.'},
    {'question': 'Why check privacy settings?', 'answer': 'To keep your account safe and private.'},
    {'question': 'What is a hacker?', 'answer': 'Someone who breaks into devices or accounts.'},
    {'question': 'What is a strong Wi-Fi password?', 'answer': 'One that’s long and hard to guess.'},
    {'question': 'Why not use the same password everywhere?', 'answer': 'If one is hacked, others are at risk.'},
    {'question': 'What is a safe chat?', 'answer': 'Chatting only with people you know.'},
    {'question': 'Why report bad behavior online?', 'answer': 'To keep the internet safe for everyone.'},
    {'question': 'What is a software update?', 'answer': 'New fixes to keep your device safe.'},
    {'question': 'What is a VPN?', 'answer': 'A tool to make your internet use private.'},
    {'question': 'Why avoid free game downloads?', 'answer': 'They might have viruses or scams.'},
    {'question': 'What is a digital footprint?', 'answer': 'The info you leave online, like posts.'},
    {'question': 'Why be careful what you post?', 'answer': 'It stays online and others can see it.'},
    {'question': 'What is a safe browser?', 'answer': 'One with tools to block bad websites.'},
  ],
  'Full': [
    {'question': 'What is two-factor authentication?', 'answer': 'Using two ways to prove it’s you.'},
    {'question': 'Why update software?', 'answer': 'To fix security issues and stay safe.'},
    {'question': 'What is encryption?', 'answer': 'Scrambling data so only you can read it.'},
    {'question': 'What is a data breach?', 'answer': 'When your info is stolen from a website.'},
    {'question': 'Why use different emails for accounts?', 'answer': 'To limit damage if one is hacked.'},
    {'question': 'What is malware?', 'answer': 'Bad software that harms your device.'},
    {'question': 'Why avoid suspicious downloads?', 'answer': 'They might install malware.'},
    {'question': 'What is a cookie in browsing?', 'answer': 'A file that tracks your online activity.'},
    {'question': 'Why clear cookies sometimes?', 'answer': 'To protect your privacy online.'},
    {'question': 'What is a secure password manager?', 'answer': 'A tool to store passwords safely.'},
    {'question': 'Why not share your location online?', 'answer': 'To keep where you are private.'},
    {'question': 'What is social engineering?', 'answer': 'Tricking people to get their info.'},
    {'question': 'Why check website URLs?', 'answer': 'To avoid fake sites that steal info.'},
    {'question': 'What is a secure backup?', 'answer': 'Saving your data safely in another place.'},
    {'question': 'Why back up your data?', 'answer': 'To recover it if your device is lost.'},
    {'question': 'What is a bot online?', 'answer': 'A program that pretends to be a person.'},
    {'question': 'Why avoid clicking ads?', 'answer': 'Some ads lead to scams or malware.'},
    {'question': 'What is a secure app store?', 'answer': 'A trusted place to download apps.'},
    {'question': 'Why review app permissions?', 'answer': 'To control what the app can access.'},
    {'question': 'What is a safe online game?', 'answer': 'One with good privacy and no strangers.'},
  ],
};

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  String selectedLevel = 'Learner';
  int currentCardIndex = 0;
  bool showAnswer = false;
  bool isLearnerCompleted = false;
  bool isProbationaryCompleted = false;
  bool isLearnerPassed = false;
  bool isProbationaryPassed = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLearnerCompleted = prefs.getBool('isLearnerCompleted') ?? false;
      isProbationaryCompleted = prefs.getBool('isProbationaryCompleted') ?? false;
      isLearnerPassed = prefs.getBool('isLearnerPassed') ?? false;
      isProbationaryPassed = prefs.getBool('isProbationaryPassed') ?? false;
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLearnerCompleted', isLearnerCompleted);
    await prefs.setBool('isProbationaryCompleted', isProbationaryCompleted);
    await prefs.setBool('isLearnerPassed', isLearnerPassed);
    await prefs.setBool('isProbationaryPassed', isProbationaryPassed);
  }

  void _nextCard() {
    setState(() {
      if (currentCardIndex < flashcards[selectedLevel]!.length - 1) {
        currentCardIndex++;
        showAnswer = false;
      } else {
        if (selectedLevel == 'Learner') {
          isLearnerCompleted = true;
        } else if (selectedLevel == 'Probationary') {
          isProbationaryCompleted = true;
        }
        _saveProgress();
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (currentCardIndex > 0) {
        currentCardIndex--;
        showAnswer = false;
      }
    });
  }

  void _goToTesting() {
    setState(() {
      if (selectedLevel == 'Learner') {
        isLearnerCompleted = true;
      } else if (selectedLevel == 'Probationary') {
        isProbationaryCompleted = true;
      }
      _saveProgress();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestingScreen(
            level: selectedLevel,
            onPass: (bool passed) {
              setState(() {
                if (selectedLevel == 'Learner') {
                  isLearnerPassed = passed;
                } else if (selectedLevel == 'Probationary') {
                  isProbationaryPassed = passed;
                }
                _saveProgress();
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentFlashcards = flashcards[selectedLevel]!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF58CC02),
        title: Text(
          'CyberLicence',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLevelButton('Learner', isLearnerCompleted, true, const Color(0xFFFFC200)),
                    _buildLevelButton('Probationary', isProbationaryCompleted, isLearnerCompleted && isLearnerPassed, const Color(0xFFE53935)),
                    _buildLevelButton('Full', false, isLearnerCompleted && isLearnerPassed && isProbationaryCompleted && isProbationaryPassed, const Color(0xFF4CAF50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FlipInY(
                  duration: const Duration(milliseconds: 400),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAnswer = !showAnswer;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            showAnswer
                                ? currentFlashcards[currentCardIndex]['answer']!
                                : currentFlashcards[currentCardIndex]['question']!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF212121),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            showAnswer ? 'Tap for Question' : 'Tap for Answer',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: const Color(0xFF616161),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomIn(
                    child: ElevatedButton(
                      onPressed: currentCardIndex > 0 ? _previousCard : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC200),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 2,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            'Back',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ZoomIn(
                    child: ElevatedButton(
                      onPressed: currentCardIndex < currentFlashcards.length - 1 ? _nextCard : _goToTesting,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF58CC02),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 2,
                      ),
                      child: Row(
                        children: [
                          Text(
                            currentCardIndex < currentFlashcards.length - 1 ? 'Next' : 'Finish',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (currentCardIndex == currentFlashcards.length - 1 &&
                  ((selectedLevel == 'Learner' && isLearnerCompleted) ||
                      (selectedLevel == 'Probationary' && isLearnerCompleted && isLearnerPassed && isProbationaryCompleted) ||
                      (selectedLevel == 'Full' && isLearnerCompleted && isLearnerPassed && isProbationaryCompleted && isProbationaryPassed)))
                ZoomIn(
                  child: ElevatedButton(
                    onPressed: _goToTesting,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'Go to Puzzles',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(String level, bool isCompleted, bool isUnlocked, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ZoomIn(
        child: ElevatedButton(
          onPressed: isUnlocked
              ? () {
                  setState(() {
                    selectedLevel = level;
                    currentCardIndex = 0;
                    showAnswer = false;
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isCompleted ? const Color(0xFF4CAF50) : color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(100, 40),
            elevation: 2,
          ),
          child: Text(
            level,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isUnlocked ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}