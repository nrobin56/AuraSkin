import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const AuraSkinApp());
}

class AuraSkinApp extends StatelessWidget {
  const AuraSkinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AuraSkin",
      debugShowCheckedModeBanner: false,

      // Global AuraSkin Theme
      theme: ThemeData(
        fontFamily: "Parkinsans",

        // App Background Color
        scaffoldBackgroundColor: const Color.fromARGB(255, 239, 201, 160),

        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 203, 107, 241), // lavender
          brightness: Brightness.light,
        ),

        // AppBar Style
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFECCFA3),
          titleTextStyle: TextStyle(
            fontFamily: "Parkinsans",
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 203, 107, 241),
          ),
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 203, 107, 241),
          ),
        ),

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 203, 107, 241),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontFamily: "Parkinsans",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
