import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider
import 'package:alzimerapp/provider/provider.dart'; // Import ThemeProvider
import 'package:alzimerapp/screens/SplashScreen.dart'; // Import SplashScreen
import 'package:alzimerapp/screens/homeScreen.dart'; // Import HomeScreen
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'firebase_options.dart'; // Import DefaultFirebaseOptions

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(), // Your theme provider
        ),
        ChangeNotifierProvider(
          create: (_) => FontProvider(), // Your font provider
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return MaterialApp(
          title: 'Alzheimer Detection App',
          theme: ThemeData(
            // Apply the selected font dynamically using GoogleFonts
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.getFont(fontProvider.currentFont),
              bodyMedium: GoogleFonts.getFont(fontProvider.currentFont),
              bodySmall: GoogleFonts.getFont(fontProvider.currentFont),
              displayLarge: GoogleFonts.getFont(fontProvider.currentFont),
              displayMedium: GoogleFonts.getFont(fontProvider.currentFont),
              displaySmall: GoogleFonts.getFont(fontProvider.currentFont),
              headlineLarge: GoogleFonts.getFont(fontProvider.currentFont),
              headlineMedium: GoogleFonts.getFont(fontProvider.currentFont),
              headlineSmall: GoogleFonts.getFont(fontProvider.currentFont),
              labelLarge: GoogleFonts.getFont(fontProvider.currentFont),
              labelMedium: GoogleFonts.getFont(fontProvider.currentFont),
              labelSmall: GoogleFonts.getFont(fontProvider.currentFont),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.getFont(fontProvider.currentFont),
              bodyMedium: GoogleFonts.getFont(fontProvider.currentFont),
              bodySmall: GoogleFonts.getFont(fontProvider.currentFont),
              displayLarge: GoogleFonts.getFont(fontProvider.currentFont),
              displayMedium: GoogleFonts.getFont(fontProvider.currentFont),
              displaySmall: GoogleFonts.getFont(fontProvider.currentFont),
              headlineLarge: GoogleFonts.getFont(fontProvider.currentFont),
              headlineMedium: GoogleFonts.getFont(fontProvider.currentFont),
              headlineSmall: GoogleFonts.getFont(fontProvider.currentFont),
              labelLarge: GoogleFonts.getFont(fontProvider.currentFont),
              labelMedium: GoogleFonts.getFont(fontProvider.currentFont),
              labelSmall: GoogleFonts.getFont(fontProvider.currentFont),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: Provider.of<ThemeProvider>(context).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home:
              _buildHomeScreen(), // Set the home screen based on authentication state
        );
      },
    );
  }

  // Function to check if the user is logged in and navigate accordingly
  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Listen to auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can display a loading indicator while checking auth state
          return SplashScreen();
        } else if (snapshot.hasData) {
          // If user is logged in, navigate to HomeScreen
          return HomeScreen();
        } else {
          // If no user is logged in, navigate to SplashScreen (or LoginPage)
          return SplashScreen();
        }
      },
    );
  }
}
