import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Ensure to import FontProvider

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  // Method to handle the password reset logic
  void _resetPassword() {
    final email = _emailController.text;
    if (email.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset link sent to $email")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to Login page
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Title
                Text(
                  'Forgot Password',
                  style: GoogleFonts.getFont(
                    Provider.of<FontProvider>(context)
                        .currentFont, // Dynamically set the font
                    color: Colors.purple,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your email to receive a password reset link.',
                  style: GoogleFonts.getFont(
                    Provider.of<FontProvider>(context)
                        .currentFont, // Dynamically set the font
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email input field
                Card(
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: GoogleFonts.getFont(
                        Provider.of<FontProvider>(context)
                            .currentFont, // Dynamically set the font
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.purple),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Reset Password button
                ElevatedButton(
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    elevation: 5,
                  ),
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.getFont(
                      Provider.of<FontProvider>(context)
                          .currentFont, // Dynamically set the font
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Back to Login button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to Login page
                  },
                  child: Text(
                    'Back to Login',
                    style: GoogleFonts.getFont(
                      Provider.of<FontProvider>(context)
                          .currentFont, // Dynamically set the font
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
