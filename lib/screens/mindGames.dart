import 'package:alzimerapp/screens/cognitive_test.dart';
import 'package:alzimerapp/screens/drawingPage.dart';
import 'package:alzimerapp/screens/stroop_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider

class MindGamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(16),
          iconSize: 36,
          splashRadius: 24,
        ),
        backgroundColor: const Color.fromARGB(255, 248, 234, 247),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 234, 247),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 'Mind Games' Text updated to use dynamic font
              Text(
                'Mind Games',
                style: GoogleFonts.getFont(
                  Provider.of<FontProvider>(context).currentFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // First row with two buttons: Cognitive Test and Memory Test
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CognitiveTestPage()),
                      );
                    },
                    child: Text(
                      'Cognitive Test',
                      style: GoogleFonts.getFont(
                        Provider.of<FontProvider>(context).currentFont,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      minimumSize: Size(150, 100),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StroopTestPage()),
                      );
                    },
                    child: Text(
                      'Stroop Test',
                      style: GoogleFonts.getFont(
                        Provider.of<FontProvider>(context).currentFont,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      minimumSize: Size(150, 100),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Second row with one button: Drawing Test
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingTestPage()),
                      );
                    },
                    child: Text(
                      'Drawing Test',
                      style: GoogleFonts.getFont(
                        Provider.of<FontProvider>(context).currentFont,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 100),
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MindGamesPage());
}
