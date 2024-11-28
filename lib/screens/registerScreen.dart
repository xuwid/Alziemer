import 'dart:io';

import 'package:alzimerapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider
import 'package:provider/provider.dart';

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _selectedImage; // Store the selected image
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Method to check permissions and pick image
  Future<void> _pickImage(ImageSource source) async {
    // Request permission for camera or gallery
    if (source == ImageSource.camera) {
      final cameraStatus = await Permission.camera.request();
      if (cameraStatus.isGranted) {
        _pickImageFromSource(source);
      } else {
        _showPermissionDeniedSnackbar("Camera permission denied.");
      }
    } else if (source == ImageSource.gallery) {
      final galleryStatus = await Permission.photos.request();
      if (galleryStatus.isGranted) {
        _pickImageFromSource(source);
      } else {
        _showPermissionDeniedSnackbar("Gallery permission denied.");
      }
    }
  }

  // Method to pick the image once permission is granted
  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  // Method to show permission denied message
  void _showPermissionDeniedSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Method to register user and store data in Firestore
  Future<void> _registerUser() async {
    try {
      // Register user using Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'email': _emailController.text.trim(),
        'profile_picture': _selectedImage != null ? _selectedImage!.path : null,
      });

      // After successful registration, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error registering: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsets.all(16),
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
                    Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: fontProvider.currentFont,
                          color: Colors.purple,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Glad to have you here',
                      style: TextStyle(
                        fontFamily: fontProvider.currentFont,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField('Name', fontProvider, _nameController),
                    const SizedBox(height: 20),
                    _buildTextField('Age', fontProvider, _ageController),
                    const SizedBox(height: 20),
                    _buildSelectPictureButton(fontProvider),
                    const SizedBox(height: 20),
                    _buildTextField(
                        'Email address', fontProvider, _emailController),
                    const SizedBox(height: 20),
                    _buildTextField(
                        'Password', fontProvider, _passwordController),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: _registerUser,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.purple),
                          ),
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: Colors.purple,
                        ),
                        child: const Icon(Icons.login,
                            size: 28, color: Colors.purple),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectPictureButton(FontProvider fontProvider) {
    return Card(
      elevation: 20,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: Text(
                      'Take a photo',
                      style: TextStyle(fontFamily: fontProvider.currentFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: Text(
                      'Choose from gallery',
                      style: TextStyle(fontFamily: fontProvider.currentFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.attach_file, color: Colors.purple),
              const SizedBox(width: 10),
              Text(
                'Select picture',
                style: TextStyle(
                  fontFamily: fontProvider.currentFont,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              if (_selectedImage != null)
                CircleAvatar(
                  backgroundImage: FileImage(_selectedImage!),
                  radius: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, FontProvider fontProvider,
      TextEditingController controller) {
    return Card(
      elevation: 20,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: fontProvider.currentFont,
            color: Colors.grey,
          ),
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
