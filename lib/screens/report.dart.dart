import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import your FontProvider

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Makes the column take minimal vertical space
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReportTitle('Test Report', context),
                      _buildTestCard('Cognitive Test', 20, 30, '1.2s',
                          'Good progress!', context),
                      _buildTestCard('Scrooping Test', 18, 30, '1.5s',
                          'Can improve further.', context),
                      _buildTestCard('Drawing Test', 25, 30, '1.1s',
                          'Excellent!', context),
                      _buildMRIScanReport(context),
                      _buildTestDateAndTime(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportTitle(String title, BuildContext context) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.getFont(
          Provider.of<FontProvider>(context).currentFont,
        ).copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTestCard(String testName, int correctAnswers, int totalQuestions,
      String averageTime, String message, BuildContext context) {
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
              style: GoogleFonts.getFont(
                Provider.of<FontProvider>(context).currentFont,
              ).copyWith(
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
                  style: GoogleFonts.getFont(
                    Provider.of<FontProvider>(context).currentFont,
                  ).copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Text(
              'Average Time: $averageTime',
              style: GoogleFonts.getFont(
                Provider.of<FontProvider>(context).currentFont,
              ).copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: GoogleFonts.getFont(
                Provider.of<FontProvider>(context).currentFont,
              ).copyWith(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMRIScanReport(BuildContext context) {
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
              style: GoogleFonts.getFont(
                Provider.of<FontProvider>(context).currentFont,
              ).copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No abnormalities detected.',
              style: GoogleFonts.getFont(
                Provider.of<FontProvider>(context).currentFont,
              ).copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestDateAndTime(BuildContext context) {
    return Center(
      child: Text(
        'Test Date & Time: ${DateTime.now().toLocal()}',
        style: GoogleFonts.getFont(
          Provider.of<FontProvider>(context).currentFont,
        ).copyWith(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
