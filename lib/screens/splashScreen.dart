import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'package:alzimerapp/screens/Start.dart'; // Import StartPage
import 'package:provider/provider.dart'; // Import provider
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer to simulate a splash screen delay of 3 seconds
    Timer(Duration(seconds: 3), () {
      // After 3 seconds, navigate to StartPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen for the font provider to apply the correct font
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 248, 234, 247),
          // A curved background
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Curved logo inside ClipRRect
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0), // Rounded corners
                  child: Image.asset(
                    'lib/assets/logo.png', // Ensure the path is correct
                    width: 150, // Adjust the logo size
                    height: 150,
                  ),
                ),
                SizedBox(height: 20), // Space between the logo and text
                // You can add any text or other widgets here if needed
              ],
            ),
          ),
        );
      },
    );
  }
}
