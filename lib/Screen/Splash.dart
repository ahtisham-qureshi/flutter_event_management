import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    // 1. Always wrap a screen in a Scaffold
    return Scaffold(
      body: Container(
        // Ensure the gradient stretches across the whole screen width
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A), // Deep Slate
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "version 1.0.0",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70, // Subtle white
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Logo / Icon
              const Icon(
                Icons.event,
                size: 70,
                color: Color(0xFF8B5CF6), // Bright pop of color
              ),
              const SizedBox(height: 20),

              const Text(
                "Event Management System",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2, // Adds a premium feel
                ),
              ),
              const SizedBox(height: 40),

              const CircularProgressIndicator(color: Color(0xFF8B5CF6)),
              const SizedBox(height: 20),
              Text(
                "Loading...",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),

              const Spacer(),

              // Copyright Text
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Copyright © 2026 Maq. All rights reserved.",
                  style: TextStyle(
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
