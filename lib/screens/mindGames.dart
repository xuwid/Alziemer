import 'package:alzimerapp/screens/cognitive_test.dart';
import 'package:alzimerapp/screens/drawingPage.dart';
import 'package:alzimerapp/screens/stroop_test.dart';
import 'package:flutter/material.dart';

class MindGamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mind Games',
                style: TextStyle(
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
                    child: Text('Cognitive Test'),
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
                    child: Text('Stroop Test'),
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
                    child: Text('Drawing Test'),
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
