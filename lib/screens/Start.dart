import 'package:alzimerapp/screens/loginScreen.dart';
import 'package:alzimerapp/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _images = [
    'lib/assets/bg.jpg',
    'lib/assets/bg1.jpg',
    'lib/assets/bg2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 234, 247),
      body: Column(
        children: [
          // Top section: PageView that takes 60% of the screen height
          Container(
            height:
                MediaQuery.of(context).size.height * 0.60, // 60% of the height
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width * 0.5,
                        100,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width * 0.5,
                        100,
                      ),
                    ),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          // Spacer between the PageView and the buttons
          SizedBox(height: 20),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_images.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: _currentPage == index
                      ? Colors.purple
                      : Colors.grey.shade300,
                ),
              );
            }),
          ),

          // Bottom section: Buttons and other content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      // Pushing to Login Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity,
                          50), // Full-width button, with height of 50
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 10, // Adds elevation for a raised effect
                      shadowColor: Colors.purple
                          .withOpacity(0.5), // Shadow color for the button
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Register Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      // Pushing to Register Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registerscreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity,
                          50), // Full-width button, with height of 50
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 10, // Adds elevation for a raised effect
                      shadowColor: Colors.purple
                          .withOpacity(0.5), // Shadow color for the button
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
