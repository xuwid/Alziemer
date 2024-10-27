import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:alzimerapp/screens/Start.dart';
import 'package:alzimerapp/provider/provider.dart'; // Import the theme provider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // Provide ThemeProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Alzheimer App',
          theme: ThemeData(
            // Ensure brightness matches ColorScheme
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light, // Set brightness explicitly
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            // Ensure brightness matches ColorScheme
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark, // Set brightness explicitly
            ),
            useMaterial3: true,
          ),
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light, // Switch theme mode
          home: StartPage(),
        );
      },
    );
  }
}
