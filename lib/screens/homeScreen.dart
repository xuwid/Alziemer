import 'package:alzimerapp/screens/accountScreen.dart';
import 'package:alzimerapp/screens/mindGames.dart';
import 'package:alzimerapp/screens/mriScan.dart';
import 'package:alzimerapp/screens/report.dart.dart';
import 'package:alzimerapp/screens/result.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // This will hold the widget for each tab
  final List<Widget> _children = [
    HomeTab(),
    ReportPage(),
    ResultPage(),
    AccountInfoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

// The Home tab with buttons and layout
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle MRI Scan button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MRIPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
              side: BorderSide(color: Colors.purple),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'MRI SCAN',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'OR',
            style: TextStyle(
              fontSize: 24,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle Mind Games button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MindGamesPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
              side: BorderSide(color: Colors.purple),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'MIND GAMES',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
