import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:alzimerapp/provider/fontprovider.dart'; // Import your FontProvider

class DrawingTestPage extends StatefulWidget {
  @override
  _DrawingTestPageState createState() => _DrawingTestPageState();
}

class _DrawingTestPageState extends State<DrawingTestPage> {
  List<DrawingPoint?> _points = [];
  Color _selectedColor = Colors.black;
  double _strokeWidth = 4.0;
  GlobalKey _canvasKey = GlobalKey(); // Key for capturing the canvas

  // List of Flutter icons (you can use any icons available in Flutter)
  List<IconData> _icons = [
    Icons.watch, // Watch icon
    Icons.access_time, // Clock icon
    Icons.calendar_today, // Calendar icon
    Icons.lightbulb, // Light bulb icon
    Icons.home, // Home icon
  ];

  int _currentIconIndex = 0; // Current index of the displayed icon

  @override
  Widget build(BuildContext context) {
    // Access the FontProvider to get the current selected font
    String currentFont = Provider.of<FontProvider>(context).currentFont;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drawing Test',
          style: TextStyle(fontFamily: currentFont), // Apply the selected font
        ),
        backgroundColor: const Color.fromARGB(255, 248, 234, 247),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(16),
          iconSize: 36,
          splashRadius: 24,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 234, 247),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Display the icon to be drawn
          Text(
            'Draw the following icon:',
            style: TextStyle(
                fontSize: 20,
                fontFamily: currentFont), // Apply the selected font
          ),
          SizedBox(height: 10),
          Icon(
            _icons[_currentIconIndex], // Show the current icon
            size: 100, // Adjust the size of the icon
          ),
          SizedBox(height: 10),
          // Drawing canvas
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _points.add(DrawingPoint(
                    points: details.localPosition,
                    paint: Paint()
                      ..color = _selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = _strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ));
                });
              },
              onPanEnd: (details) {
                _points.add(null); // End of drawing stroke
              },
              child: RepaintBoundary(
                key: _canvasKey, // Key for capturing the drawing
                child: CustomPaint(
                  painter: DrawingPainter(_points),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          // Control options for stroke and color
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.color_lens),
                onPressed: () {
                  // Show a color picker
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Pick a color',
                        style: TextStyle(
                            fontFamily: currentFont), // Apply the selected font
                      ),
                      content: BlockPicker(
                        pickerColor: _selectedColor,
                        onColorChanged: (color) {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'Close',
                            style: TextStyle(
                                fontFamily:
                                    currentFont), // Apply the selected font
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Slider(
                min: 1.0,
                max: 10.0,
                value: _strokeWidth,
                onChanged: (value) {
                  setState(() {
                    _strokeWidth = value;
                  });
                },
              ),
              // Add a Clear Canvas button
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  // Clear the canvas
                  setState(() {
                    _points.clear();
                  });
                },
                tooltip: 'Clear Canvas',
              ),
            ],
          ),
          // Submit button to save drawing and move to next icon
          ElevatedButton(
            onPressed: () async {
              ui.Image drawnImage =
                  await _capturePng(); // Capture the drawing as an image
              ui.Image iconImage = await _captureIconImage(
                  _icons[_currentIconIndex]); // Capture icon as image

              bool isMatch = await compareImages(drawnImage, iconImage);

              if (isMatch) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Drawing matches the icon!",
                    style: TextStyle(
                        fontFamily: currentFont), // Apply the selected font
                  ),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Drawing does not match the icon.",
                    style: TextStyle(
                        fontFamily: currentFont), // Apply the selected font
                  ),
                ));
              }

              setState(() {
                if (_currentIconIndex < _icons.length - 1) {
                  _currentIconIndex++;
                  _points.clear(); // Clear the canvas for the next drawing
                } else {
                  _showCompletionDialog(); // Show completion dialog when all icons are done
                }
              });
            },
            child: Text(
              'Submit Drawing',
              style:
                  TextStyle(fontFamily: currentFont), // Apply the selected font
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Capture the canvas drawing as an image
  Future<ui.Image> _capturePng() async {
    RenderRepaintBoundary boundary =
        _canvasKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    return image;
  }

  // Capture the icon as an image for comparison
  Future<ui.Image> _captureIconImage(IconData iconData) async {
    final recorder = ui.PictureRecorder();
    final canvas =
        Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(100, 100)));

    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
          fontSize: 100.0,
          fontFamily: iconData.fontFamily,
          color: Colors.black),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, 0));

    final picture = recorder.endRecording();
    return picture.toImage(100, 100);
  }

  // Compare two images pixel by pixel
  Future<bool> compareImages(ui.Image drawnImage, ui.Image iconImage) async {
    ByteData? drawnData =
        await drawnImage.toByteData(format: ui.ImageByteFormat.rawRgba);
    ByteData? iconData =
        await iconImage.toByteData(format: ui.ImageByteFormat.rawRgba);

    if (drawnData == null || iconData == null) return false;

    int totalPixels = drawnData.lengthInBytes ~/ 4;
    int threshold = 250; // Allowable difference between pixel values

    for (int i = 0; i < totalPixels; i++) {
      int drawnPixel = drawnData.getUint32(i * 4);
      int iconPixel = iconData.getUint32(i * 4);

      if ((drawnPixel - iconPixel).abs() > threshold) {
        return false; // Images are too different
      }
    }
    return true; // Images are similar
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Test Completed',
          style: TextStyle(
              fontFamily: Provider.of<FontProvider>(context)
                  .currentFont), // Apply the selected font
        ),
        content: Text(
          'You have completed all drawing tasks!',
          style: TextStyle(
              fontFamily: Provider.of<FontProvider>(context)
                  .currentFont), // Apply the selected font
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                  fontFamily: Provider.of<FontProvider>(context)
                      .currentFont), // Apply the selected font
            ),
          ),
        ],
      ),
    );
  }
}

class DrawingPoint {
  Paint paint;
  Offset points;

  DrawingPoint({required this.paint, required this.points});
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoint?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (var point in points) {
      if (point != null) {
        canvas.drawCircle(
            point.points, point.paint.strokeWidth / 2, point.paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
