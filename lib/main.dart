import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/screens/booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9D4EDD), // Amethyst Purple
          primary: const Color(0xFF9D4EDD),
          secondary: const Color(0xFFC77DFF), // Light Purple
          surface: const Color(0xFFFAF5FF), // Purple 50
          error: const Color(0xFFEF4444), // Red 500
          onSurface: const Color(0xFF240046), // Dark Purple
        ),
        scaffoldBackgroundColor: const Color(0xFFF3E8FF), // Purple 100
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF0F172A), // Slate 900
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE2E8F0), width: 1), // Slate 200
          ),
          color: Colors.white,
        ),
      ),
      home: const BookingScreen(),
    );
  }
}

