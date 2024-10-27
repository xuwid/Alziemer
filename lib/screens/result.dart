import 'package:flutter/material.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final TextEditingController _controller = TextEditingController();
  String report = ''; // To store and display the generated report

  // Function to simulate generating a random report/stage
  void _generateReport() {
    // This could be more complex logic. For now, just showing a random result.
    List<String> stages = [
      'No Cognitive Impairment',
      'Mild Cognitive Impairment',
      'Early Alzheimer’s Disease',
      'Moderate Alzheimer’s Disease',
      'Severe Alzheimer’s Disease'
    ];

    // Select a random stage
    setState(() {
      report = stages[Random().nextInt(stages.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // Test Summary Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Test Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'This section provides a brief overview of your previous cognitive test results. It can include the total number of tests completed, average scores, and progress over time.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Placeholder for Graphical Representation (e.g., Test Progress)
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: Text(
                      'Graphical Representation (e.g., Progress Over Time)',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Prediction Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prediction',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Combine result of all games',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 20),
                      // Display the generated report
                      if (report.isNotEmpty)

                        //Display combined result of all games

                        Text(
                          'Combined result of all games:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      Text('Drawing Test: 10'),
                      Text('Cognitive Test: 15'),
                      Text('Scrooping Test: 1.2'),
                      Text(
                        'Report: $report',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Spacing between sections

                // Details Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detailed Insights',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Based on your results, here are some personalized recommendations and insights to help improve cognitive performance over time. For example, suggestions on specific exercises or cognitive activities.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Spacing between sections

                // Generate Prediction & Stage Button
                ElevatedButton(
                  onPressed: _generateReport,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Generate Prediction & Stage',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
