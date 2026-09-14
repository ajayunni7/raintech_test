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
          seedColor: const Color(0xFF4F46E5), // Indigo
          primary: const Color(0xFF4F46E5),
          secondary: const Color(0xFF0EA5E9), // Sky Blue
          surface: const Color(0xFFF8FAFC), // Slate 50
          error: const Color(0xFFEF4444), // Red 500
          onSurface: const Color(0xFF0F172A), // Slate 900
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Slate 100
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

