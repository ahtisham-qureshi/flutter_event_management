import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _SplashState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A), // Dark Blue
              Color(0xFF020617), // Lighter Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // Version Text
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "version 1.0.0",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70, // Subtle white
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Logo / Icon
              Image.asset('images/Logo.png', width: 130, height: 130),

              const SizedBox(height: 20),

              Text(
                "Event\nManagement",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600, // Semibold
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              Text(
                "Plan. Connect. Celebrate.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 50),

              const CircularProgressIndicator(color: Color(0xFFFF1493)),
              const SizedBox(height: 20),
              Text(
                "Loading...",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
              ),

              const Spacer(),

              // Copyright Text
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Copyright © 2026 Maq. All rights reserved.",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
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
