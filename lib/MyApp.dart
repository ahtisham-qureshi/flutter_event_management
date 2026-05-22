import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FragmentHolder.dart' as FragmentHolderWidget;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool nav = false;

  void isNav(bool flag) {
    nav = flag;
    setState(() {});
  }

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
        scaffoldBackgroundColor: const Color(0xFF10172A),

        // 3. Use your energetic Neon Pink as the primary brand color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF1493),
          brightness: Brightness
              .dark, // Ensures the scheme generates dark-mode appropriate contrasts
        ),

        // 4. Apply Poppins globally to all text in the app
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: Scaffold(
        appBar: nav
            ? AppBar(
                backgroundColor: const Color(0xFF1E293B),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                      width: 55,
                      height: 55,
                    ),
                    Text(
                      "Event\nManagement",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: FragmentHolderWidget.FragmentHolder(isNav: isNav),
        // elevation: 0,
      ), // body: const FragmentHolderWidget.FragmentHolder(),
    );
  }
}
