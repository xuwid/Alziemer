import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 20),
          bodySmall: TextStyle(color: Colors.black54),
          bodyMedium: TextStyle(color: Colors.teal, fontSize: 24),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.all(16),
              iconSize: 36,
              splashRadius: 24,
            ),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CognitiveTestPage()),
                );
              },
              child: Text(
                'Start Cognitive Test',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CognitiveTestPage extends StatefulWidget {
  @override
  _CognitiveTestPageState createState() => _CognitiveTestPageState();
}

class _CognitiveTestPageState extends State<CognitiveTestPage> {
  final Random _random = Random();
  List<int> _sequence = [];
  List<int> _userInput = [];
  int _currentTrial = 0;
  int _maxDigits = 3;
  bool _isInputVisible = false;
  bool _isTrialComplete = false;
  int _remainingTime = 1; // Remaining time in seconds
  Timer? _countdownTimer;

  void _generateSequence() {
    _sequence = List.generate(_maxDigits, (_) => _random.nextInt(10));
    setState(() {
      _isInputVisible = false;
      _isTrialComplete = false;
      _remainingTime = 1; // Reset remaining time for the new trial
    });
    _showSequence();
  }

  void _showSequence() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remember the sequence!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _sequence.join(' '),
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Remaining time: $_remainingTime seconds',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );

    // Start countdown timer
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime <= 0) {
        timer.cancel();
        Navigator.of(context).pop(); // Dismiss the dialog
        _startInput(); // Start the input phase
      }
    });
  }

  void _startInput() {
    setState(() {
      _isInputVisible = true;
      _userInput.clear();
      _currentTrial++;
      _isTrialComplete = false;
    });
  }

  void _checkInput() {
    setState(() {
      _isTrialComplete = true;
      _countdownTimer?.cancel(); // Stop the countdown timer
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Your Input'),
          content: Text(
            _userInput.join(' ') == _sequence.join(' ')
                ? 'Correct!'
                : 'Incorrect! The correct sequence was: ${_sequence.join(' ')}',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_currentTrial < 3) {
                  _maxDigits++;
                  _generateSequence();
                } else {
                  _showFinalResults();
                }
              },
              child: Text('Next Trial'),
            ),
          ],
        );
      },
    );
  }

  void _showFinalResults() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Test Complete'),
          content: Text('You completed $_currentTrial trials.'),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Go back to HomeScreen
              },
              child: Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cognitive Test', style: TextStyle(fontSize: 24)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.all(16),
              iconSize: 36,
              splashRadius: 24,
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isInputVisible) ...[
                  Text(
                    'Trial $_currentTrial',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _generateSequence,
                    child: Text('Start Trial'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    'Enter the sequence:',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8.0,
                    children: List.generate(10, (index) {
                      return ElevatedButton(
                        onPressed: _isTrialComplete
                            ? null
                            : () {
                                setState(() {
                                  _userInput.add(index);
                                });
                              },
                        child: Text(index.toString()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isTrialComplete ? Colors.grey : Colors.teal,
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isTrialComplete ? null : _checkInput,
                    child: Text('Check Input'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  if (_isTrialComplete) ...[
                    SizedBox(height: 20),
                    Text('Your Input: ${_userInput.join(' ')}',
                        style: TextStyle(fontSize: 18)),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
