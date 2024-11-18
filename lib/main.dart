import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alzimerapp/screens/Start.dart'; // Your start page
import 'package:alzimerapp/provider/provider.dart'; // Your theme provider
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:alzimerapp/provider/fontprovider.dart'; // Import the FontProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider()), // Your theme provider
        ChangeNotifierProvider(
            create: (_) => FontProvider()), // Provide FontProvider
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
              // Apply Google font to bodyLarge (or bodyText1 for older versions)
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
              // Add other text styles if needed
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            // Apply the selected font dynamically for dark mode
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
          home: StartPage(),
        );
      },
    );
  }
}
