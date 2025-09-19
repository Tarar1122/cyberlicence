import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificateDownloadScreen extends StatefulWidget {
  final String level;

  const CertificateDownloadScreen({super.key, required this.level});

  @override
  _CertificateDownloadScreenState createState() => _CertificateDownloadScreenState();
}

class _CertificateDownloadScreenState extends State<CertificateDownloadScreen> {
  String userName = '';
  String avatarPath = 'assets/images/avatar1.png'; // Default avatar
  List<String> avatars = [
    'assets/images/avatar.jpg',
    'assets/images/avatar1.png',
    'assets/images/avatar2.avif',
    'assets/images/avatar3.jpg',
    'assets/images/avatar4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Cyber Explorer';
      int avatarIndex = prefs.getInt('avatarIndex') ?? 0;
      avatarPath = avatars[avatarIndex % avatars.length];
    });
  }

  Future<void> _downloadCertificate() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsBold();
    final regularFont = await PdfGoogleFonts.nunitoRegular();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(30),
            width: 400,
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                colors: [
                  PdfColor.fromHex('58CC02'),
                  PdfColor.fromHex('89E219'),
                ],
              ),
              border: pw.Border.all(color: PdfColors.white, width: 2),
              borderRadius: pw.BorderRadius.circular(20),
              boxShadow: [
                pw.BoxShadow(
                  color: PdfColor.fromHex('000000'),
                  blurRadius: 8,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'CyberLicence',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 36,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  widget.level,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 28,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  userName,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 32,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Licensed to Explore the Cyberverse!',
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 20,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Issued on: September 15, 2025, 02:55 AM PKT',
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 14,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: '${widget.level}_CyberLicence.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE8F5E9).withOpacity(0.9),
              const Color(0xFFC8E6C9).withOpacity(0.9),
            ],
            stops: const [0.0, 0.8],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Enhanced Confetti Effect
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    children: List.generate(30, (index) {
                      return Positioned(
                        top: (index * 60 + Random().nextInt(100)) % MediaQuery.of(context).size.height,
                        left: (index * 80 + Random().nextInt(100)) % MediaQuery.of(context).size.width,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: Random().nextDouble(),
                          child: Container(
                            width: Random().nextDouble() * 15 + 5,
                            height: Random().nextDouble() * 15 + 5,
                            decoration: BoxDecoration(
                              color: index % 3 == 0
                                  ? const Color(0xFF58CC02)
                                  : index % 3 == 1
                                      ? const Color(0xFFFFC200)
                                      : const Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                      child: Text(
                        '🎉 Your CyberLicence! 🎉',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ZoomIn(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF58CC02), Color(0xFF89E219)],
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              spreadRadius: 3,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              avatarPath,
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.person,
                                size: 120,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              userName,
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Licensed to Explore the Cyberverse!',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.level,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Issued: September 15, 2025, 02:55 AM PKT',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    BounceInUp(
                      child: ElevatedButton(
                        onPressed: _downloadCertificate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          elevation: 10,
                        ),
                        child: Text(
                          'Download My Licence',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BounceInUp(
                      delay: const Duration(milliseconds: 200),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          elevation: 10,
                        ),
                        child: Text(
                          'Back to Cards',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}