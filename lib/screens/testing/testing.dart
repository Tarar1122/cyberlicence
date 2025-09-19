import 'package:cyber_licence/screens/completion/completion.dart';
import 'package:cyber_licence/screens/flashcard/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math';

class TestingScreen extends StatefulWidget {
  final String level;
  final Function(bool) onPass;

  const TestingScreen({super.key, required this.level, required this.onPass});

  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  List<Map<String, String>> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  List<int> usedIndices = [];
  Random random = Random();
  List<String> answerOptions = [];
  String? selectedAnswer; // Track the selected answer

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('score_${widget.level}') ?? 0;
      currentQuestionIndex = prefs.getInt('currentQuestionIndex_${widget.level}') ?? 0;
      usedIndices = (prefs.getString('usedIndices_${widget.level}') ?? '')
          .split(',')
          .where((s) => s.isNotEmpty)
          .map((s) => int.parse(s))
          .toList();
      if (usedIndices.isNotEmpty && currentQuestionIndex < 10) {
        questions = flashcards[widget.level]!
            .asMap()
            .entries
            .where((entry) => usedIndices.contains(entry.key))
            .map((entry) => entry.value)
            .toList();
        if (questions.isNotEmpty) {
          _generateAnswerOptions();
        }
      } else {
        _loadQuestions();
      }
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score_${widget.level}', score);
    await prefs.setInt('currentQuestionIndex_${widget.level}', currentQuestionIndex);
    await prefs.setString('usedIndices_${widget.level}', usedIndices.join(','));
  }

  void _loadQuestions() {
    final allQuestions = flashcards[widget.level]!;
    usedIndices.clear();
    questions.clear();
    while (usedIndices.length < 10 && allQuestions.isNotEmpty) {
      int index = random.nextInt(allQuestions.length);
      if (!usedIndices.contains(index)) {
        usedIndices.add(index);
        questions.add(allQuestions[index]);
      }
    }
    _generateAnswerOptions();
    _saveProgress();
    setState(() {});
  }

  void _generateAnswerOptions() {
    if (currentQuestionIndex >= questions.length) return;
    final allAnswers = flashcards[widget.level]!.map((q) => q['answer']!).toList();
    answerOptions.clear();
    answerOptions.add(questions[currentQuestionIndex]['answer']!); // Correct answer
    while (answerOptions.length < 4) { // 4 options
      final randomAnswer = allAnswers[random.nextInt(allAnswers.length)];
      if (randomAnswer != answerOptions[0] && !answerOptions.contains(randomAnswer)) {
        answerOptions.add(randomAnswer);
      }
    }
    answerOptions.shuffle();
    setState(() {});
  }

  void _checkAnswer(String selectedAnswer) {
    setState(() {
      this.selectedAnswer = selectedAnswer;
    });
    if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
      score++;
    }
  }

  void _nextQuestion() {
    if (selectedAnswer == null) return; // Prevent moving forward without selection
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswer = null; // Reset selected answer
        _generateAnswerOptions();
      } else {
        _showResult();
      }
      _saveProgress();
    });
  }

  void _showResult() async {
    bool passed = score >= 9;
    widget.onPass(passed);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is${widget.level}Passed', passed);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: passed ? const Color(0xFFE8F5E9) : const Color(0xFFEF9A9A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 60,
                color: passed ? const Color(0xFF2E7D32) : const Color(0xFFEF5350),
              ),
              const SizedBox(height: 20),
              Text(
                passed ? 'Congratulations! 🎉' : 'Oops! Try Again! 😞',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: passed ? const Color(0xFF2E7D32) : const Color(0xFFEF5350),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                passed
                    ? 'You passed with $score/10! Ready for the next level?'
                    : 'You scored $score/10. You need 9 to pass.',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: passed ? const Color(0xFF2E7D32) : const Color(0xFFEF5350),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (passed) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompletionScreen(level: widget.level),
                      ),
                    );
                  } else {
                    setState(() {
                      score = 0;
                      currentQuestionIndex = 0;
                      selectedAnswer = null;
                      _loadQuestions();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: passed ? const Color(0xFF2E7D32) : const Color(0xFFEF5350),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  passed ? 'Next Level' : 'Retry',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!passed)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Back to Cards
                  },
                  child: Text(
                    'Back to Cards',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEF5350),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty || answerOptions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFE0F7E0), // Light green background
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Puzzle Header with Icon and Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.extension, color: Color(0xFF58CC02), size: 30),
                  const SizedBox(width: 8),
                  Text(
                    'Puzzle ${currentQuestionIndex + 1} of 10',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / 10,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF58CC02),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 20),
              // Question
              Text(
                questions[currentQuestionIndex]['question']!,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32), // Darker green
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Answer Options
              Expanded(
                child: ListView.builder(
                  itemCount: answerOptions.length,
                  itemBuilder: (context, index) {
                    final option = answerOptions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ZoomIn(
                        delay: Duration(milliseconds: 100 * index),
                        child: option == selectedAnswer
                            ? ElevatedButton(
                                onPressed: () => _checkAnswer(option),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32), // Dark green for selected
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  elevation: 2,
                                ), child:   Text(
                                  option,
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                            ))
                            : OutlinedButton(
                                onPressed: () => _checkAnswer(option),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                ),
                                child: Text(
                                  option,
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF2E7D32),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Solve Puzzle Button
              ElevatedButton(
                onPressed: selectedAnswer != null ? _nextQuestion : null, // Enable only if an answer is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 104,
                    vertical: 16,
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Solve Puzzle',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}