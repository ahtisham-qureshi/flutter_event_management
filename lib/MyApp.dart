import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screen/Splash.dart' as SplashScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management',
      theme: ThemeData(
        // 1. Set the overall brightness to dark mode
        brightness: Brightness.dark,

        // 2. Set your exact brand guide Dark Background globally
        // Now, every new Scaffold you create will have this color automatically!
        scaffoldBackgroundColor: const Color(0xFF10172A),

        // 3. Use your energetic Neon Pink as the primary brand color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF1493),
          brightness: Brightness
              .dark, // Ensures the scheme generates dark-mode appropriate contrasts
        ),

        // 4. Apply Poppins globally to all text in the app
        // We pass ThemeData.dark().textTheme inside so the default text color is white
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const SplashScreen.Splash(),
    );
  }
}
