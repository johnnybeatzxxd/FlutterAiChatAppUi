import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "index.dart";

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme();
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData.brightness == Brightness.light) {
      _themeData = darkTheme();
    } else {
      _themeData = lightTheme();
    }
    notifyListeners();
  }
}

class ThemeIconProvider extends ChangeNotifier {
  var icontype = ThemeData().brightness == Brightness.light
      ? Icons.dark_mode
      : Icons.sunny;
  void toggleIcon() {
    if (icontype == Icons.dark_mode) {
      icontype = Icons.light_mode;
    } else {
      icontype = Icons.dark_mode;
    }
    notifyListeners();
  }
}
