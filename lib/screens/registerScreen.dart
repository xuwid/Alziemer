import 'dart:io';

import 'package:alzimerapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import FontProvider

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  File? _selectedImage; // Store the selected image

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

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        return Scaffold(
          appBar: AppBar(
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
                          fontFamily: fontProvider
                              .currentFont, // Apply font dynamically
                          color: Colors.purple,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Glad to have you here',
                      style: TextStyle(
                        fontFamily:
                            fontProvider.currentFont, // Apply font dynamically
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField('Name', fontProvider),
                    const SizedBox(height: 20),
                    _buildTextField('Age', fontProvider),
                    const SizedBox(height: 20),

                    // Updated Select Picture button
                    _buildSelectPictureButton(fontProvider),

                    const SizedBox(height: 20),
                    _buildTextField('Email address', fontProvider),
                    const SizedBox(height: 20),
                    _buildTextField('Password', fontProvider),
                    const SizedBox(height: 30),

                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Or register with',
                            style: TextStyle(
                              fontFamily: fontProvider
                                  .currentFont, // Apply font dynamically
                              color: Colors.purple,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialIcon('lib/assets/google.jpg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
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

  // Button for selecting a picture
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
                      style: TextStyle(
                        fontFamily:
                            fontProvider.currentFont, // Apply font dynamically
                      ),
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
                      style: TextStyle(
                        fontFamily:
                            fontProvider.currentFont, // Apply font dynamically
                      ),
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
                  fontFamily:
                      fontProvider.currentFont, // Apply font dynamically
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

  Widget _buildTextField(String hintText, FontProvider fontProvider) {
    return Card(
      elevation: 20,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: fontProvider.currentFont, // Apply font dynamically
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
