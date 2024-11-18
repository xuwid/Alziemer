import 'package:alzimerapp/forgotPasswordPage.dart';
import 'package:alzimerapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart';

class LoginScreen extends StatelessWidget {
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
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Login Title
                Center(
                  child: Consumer<FontProvider>(
                    builder: (context, fontProvider, child) {
                      return Text(
                        'Login',
                        style: GoogleFonts.getFont(
                          fontProvider.currentFont,
                          color: Colors.purple,
                          fontSize: 32,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 8),

                // Subtitle
                Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'Glad to have you back',
                      style: GoogleFonts.getFont(
                        fontProvider.currentFont,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    );
                  },
                ),

                SizedBox(height: 30),

                // Input fields
                _buildTextField('Email address'),
                SizedBox(height: 20),
                _buildTextField('Password'),

                SizedBox(height: 20),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Consumer<FontProvider>(
                      builder: (context, fontProvider, child) {
                        return Text(
                          'Forgot Password',
                          style: GoogleFonts.getFont(
                            fontProvider.currentFont,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Social Media buttons
                Center(
                  child: Column(
                    children: [
                      Consumer<FontProvider>(
                        builder: (context, fontProvider, child) {
                          return Text(
                            'Or login with',
                            style: GoogleFonts.getFont(
                              fontProvider.currentFont,
                              color: Colors.purple,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(
                              'lib/assets/google.jpg'), // Google logo asset
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Login button (Submit icon)
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login action
                      //push to Home Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
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
