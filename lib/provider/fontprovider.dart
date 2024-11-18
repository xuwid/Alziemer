import 'package:flutter/material.dart';

class FontProvider with ChangeNotifier {
  // Default font is set to 'Roboto'
  String _currentFont = 'Roboto';

  String get currentFont => _currentFont;

  // Change the font dynamically
  void setFont(String fontName) {
    _currentFont = fontName;
    notifyListeners(); // Notify listeners to rebuild with the new font
  }
}
