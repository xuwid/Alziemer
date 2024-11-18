import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:alzimerapp/provider/fontprovider.dart';
import 'package:provider/provider.dart'; // Add provider import for accessing FontProvider

class MRIPage extends StatefulWidget {
  @override
  _MRIPageState createState() => _MRIPageState();
}

class _MRIPageState extends State<MRIPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to request gallery permission and pick an image
  void _pickImageFromGallery() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedImage;
      });
    } else {
      _showPermissionDeniedDialog();
    }
  }

  // Show alert dialog if permission is denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Gallery Permission Denied'),
        content: Text(
            'Please enable gallery permission in settings to upload an image.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the selected font from FontProvider
    final fontProvider = Provider.of<FontProvider>(context);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.all(16),
            iconSize: 36,
            splashRadius: 24,
          ),
          title: Text(
            "MRI Upload",
            style: TextStyle(fontFamily: fontProvider.currentFont),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Upload or Capture MRI Scan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontProvider.currentFont, // Dynamically set font
                ),
              ),
              SizedBox(height: 20),
              // Display the selected image
              if (_imageFile != null)
                Image.file(
                  File(_imageFile!.path),
                  height: 200,
                  width: double.infinity,
                )
              else
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey[700],
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: Icon(Icons.upload_file),
                label: Text(
                  'Upload MRI Scan',
                  style: TextStyle(
                      fontFamily:
                          fontProvider.currentFont), // Dynamically set font
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  var status = await Permission.camera.request();
                  if (status.isGranted) {
                    final pickedImage =
                        await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      _imageFile = pickedImage;
                    });
                  } else {
                    _showPermissionDeniedDialog();
                  }
                },
                icon: Icon(Icons.camera_alt),
                label: Text(
                  'Take Picture of MRI Scan',
                  style: TextStyle(
                      fontFamily:
                          fontProvider.currentFont), // Dynamically set font
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle MRI Scan button press
                  if (_imageFile != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image saved successfully!')),
                    );
                    // Code to save the image would go here
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No image selected!')),
                    );
                  }

                  // Pop to Home Screen
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
                    'Submit',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          fontProvider.currentFont, // Dynamically set font
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MRIPage());
}
