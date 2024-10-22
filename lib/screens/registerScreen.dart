import 'package:alzimerapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class Registerscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Card(
                  //make the border black
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black.withOpacity(0.4)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 20),
                    onPressed: () {
                      // Handle back button press
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.all(16),
                    iconSize: 36,
                    splashRadius: 24,
                  ),
                ),

                // Register Title
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 32,
                    //  fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Glad to have you here',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),

                SizedBox(height: 30),

                // Input fields
                _buildTextField('Name'),
                SizedBox(height: 20),
                _buildTextField('Age'),
                SizedBox(height: 20),
                _buildTextFieldWithIcon('Select picture', Icons.attach_file),
                SizedBox(height: 20),
                _buildTextField('Email address'),
                SizedBox(height: 20),
                _buildTextField('Password'),

                SizedBox(height: 30),

                // Social Media buttons
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Or register with',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(
                              'lib/assets/google.jpg'), // Google logo asset
                          // Twitter logo asset
                        ],
                      ),
                    ],
                  ),
                ),

                // Submit button (login icon)
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login action
                      //Pushing to Home Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeTab()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.purple),
                      ),
                      padding: EdgeInsets.all(5),
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shadowColor: Colors.purple,
                    ),
                    child: Icon(Icons.login, size: 28, color: Colors.purple),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a simple text field
  Widget _buildTextField(String hintText) {
    return Card(
      elevation: 20,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(17),
          // Border will be invisible
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border when focused
          ),
        ),
      ),
    );
  }

// Helper method to build a text field with an icon
  Widget _buildTextFieldWithIcon(String hintText, IconData icon) {
    return Card(
      elevation: 20,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(17),
          suffixIcon: Icon(icon, color: Colors.purple),
          // Border will be invisible
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No visible border when focused
          ),
        ),
      ),
    );
  }

  // Helper method to build social media buttons
  Widget _buildSocialIcon(String assetPath) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
