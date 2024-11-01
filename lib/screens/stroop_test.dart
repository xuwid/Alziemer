import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StroopTestPage()),
            );
          },
          child: Text('Start Stroop Test'),
        ),
      ),
    );
  }
}

class StroopTestPage extends StatefulWidget {
  @override
  _StroopTestPageState createState() => _StroopTestPageState();
}

class _StroopTestPageState extends State<StroopTestPage> {
  final List<String> colorWords = ['Red', 'Blue', 'Green', 'Yellow'];
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  String displayedWord = '';
  Color displayedColor = Colors.black;
  int totalTrials = 10;
  int currentTrial = 0;
  int correctResponses = 0;
  List<int> responseTimes = [];
  late Stopwatch stopwatch;
  late Timer countdownTimer; // Countdown timer for remaining time
  static const int timeLimit = 5000; // 5 seconds limit
  bool timeExceeded = false;
  int remainingTime = timeLimit ~/ 1000; // Remaining time in seconds
  bool isTestStarted = false;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
  }

  void _startNewTrial() {
    if (currentTrial < totalTrials) {
      setState(() {
        displayedWord = (colorWords..shuffle()).first;
        displayedColor = (colors..shuffle()).first;
        currentTrial++;
        stopwatch.reset();
        stopwatch.start();
        timeExceeded = false; // Reset for new trial
        remainingTime = timeLimit ~/ 1000; // Reset remaining time
      });

      // Start the countdown timer
      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainingTime > 0) {
          setState(() {
            remainingTime--;
          });
        } else {
          timer.cancel();
          setState(() {
            timeExceeded = true; // Mark as time exceeded
            stopwatch.stop();
            _handleUserResponse(
                Colors.transparent); // Handle as incorrect response
          });
        }
      });
    } else {
      _showResults();
    }
  }

  void _handleUserResponse(Color selectedColor) {
    stopwatch.stop();
    responseTimes.add(stopwatch.elapsedMilliseconds);

    // Check if the response is correct and the time has not exceeded
    if (selectedColor == displayedColor && !timeExceeded) {
      correctResponses++;
    }

    // Cancel the countdown timer
    countdownTimer.cancel();
    _startNewTrial(); // Start the next trial
  }

  void _showResults() {
    double averageTime = responseTimes.isNotEmpty
        ? responseTimes.reduce((a, b) => a + b) / responseTimes.length
        : 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Results'),
          content: Text(
            'Correct Responses: $correctResponses/$totalTrials\n'
            'Average Response Time: ${averageTime ~/ 1000}.${(averageTime % 1000) ~/ 10} seconds',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Pop back to home
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  void _resetTest() {
    setState(() {
      currentTrial = 0;
      correctResponses = 0;
      responseTimes.clear();
      timeExceeded = false;
      countdownTimer.cancel(); // Cancel any active countdown timer
      stopwatch.stop(); // Stop the stopwatch
    });
  }

  void _startTest() {
    setState(() {
      isTestStarted = true;
      _startNewTrial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isTestStarted) ...[
                // Container for the "Are you ready?" message and button
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        Colors.blueAccent.withOpacity(0.1), // Light background
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Are you ready?',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Explanation of the test
                      Text(
                        'In this test, you will see color names written in different colors.'
                        '\nYour task is to choose the color of the text, not the word itself.\n\n'
                        'For example, if the word "Red" is shown in blue color, you should tap on the blue button.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _startTest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            Text('Start Test', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Displayed word in mismatched color
                Text(
                  'Choose the Color',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color:
                        Colors.grey[300], // Light grey background for the word
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple, width: 1),
                  ),
                  child: Text(
                    displayedWord,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: displayedColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Timer display
                Text(
                  timeExceeded
                      ? 'Time Exceeded!'
                      : 'Remaining Time: $remainingTime seconds', // Displays remaining time
                  style: TextStyle(
                    fontSize: 24,
                    color: timeExceeded ? Colors.red : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                // Color selection buttons
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: colors.map((color) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: timeExceeded
                          ? null // Disable button if time is exceeded
                          : () => _handleUserResponse(color),
                      child: Text(''),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text('Trial $currentTrial of $totalTrials',
                    style: TextStyle(color: Colors.black)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
