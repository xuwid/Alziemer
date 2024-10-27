import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReportPage(),
    );
  }
}

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Makes the column take minimal vertical space
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReportTitle('Test Report'),
                    _buildTestCard(
                        'Cognitive Test', 20, 30, '1.2s', 'Good progress!'),
                    _buildTestCard('Scrooping Test', 18, 30, '1.5s',
                        'Can improve further.'),
                    _buildTestCard(
                        'Drawing Test', 25, 30, '1.1s', 'Excellent!'),
                    _buildMRIScanReport(),
                    _buildTestDateAndTime(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTestCard(String testName, int correctAnswers, int totalQuestions,
      String averageTime, String message) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              testName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Total Score: $correctAnswers/$totalQuestions',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Text(
              'Average Time: $averageTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMRIScanReport() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MRI Scan Report',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No abnormalities detected.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestDateAndTime() {
    return Center(
      child: Text(
        'Test Date & Time: ${DateTime.now().toLocal()}',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
