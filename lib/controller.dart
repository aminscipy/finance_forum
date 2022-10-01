import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  ThemeMode theme() {
    notifyListeners();
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    return mode;
  }
}
