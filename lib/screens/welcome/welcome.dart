import 'package:cyber_licence/screens/work/work.dart';
import 'package:cyber_licence/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedAvatar = '';
  final TextEditingController _nameController = TextEditingController();

  // List of avatar asset paths (replace with your actual image paths)
  final List<String> avatars = [
    AppImages.avatar,
    AppImages.avatar1,
    AppImages.avatar2,

    AppImages.avatar3,
    AppImages.avatar4,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              Text(
                'Welcome to CyberLicence!',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF58CC02),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Name Input
              Text(
                'Enter Your Name',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Type your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF212121)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 32),
              // Avatar Selection
              Text(
                'Choose Your Avatar',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: avatars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = avatars[index];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedAvatar == avatars[index]
                                  ? const Color(0xFF58CC02)
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              avatars[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              // Adult Confirmation
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    activeColor: const Color(0xFF58CC02),
                  ),
                  Expanded(
                    child: Text(
                      'A parent or responsible adult is present to help me.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Start Button
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      selectedAvatar.isNotEmpty) {
                    // Navigate to next screen with name and avatar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HowItWorksScreen(
                          name: _nameController.text,
                          avatarPath: selectedAvatar,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a name and choose an avatar!',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 140,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  'Start',
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
