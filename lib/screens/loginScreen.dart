import 'package:alzimerapp/screens/homeScreen.dart';
import 'package:alzimerapp/screens/forgotPasswordPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your email and password.")),
        );
        return;
      }

      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to HomeScreen if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 234, 247),
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
      backgroundColor: const Color.fromARGB(255, 248, 234, 247),
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

                // Input fields for Email and Password
                _buildTextField('Email address', _emailController),
                SizedBox(height: 20),
                _buildTextField('Password', _passwordController,
                    obscureText: true),

                SizedBox(height: 20),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password page
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

                // Login Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _login,
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

  // Helper method to build text fields for email and password
  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return Card(
      elevation: 20,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
