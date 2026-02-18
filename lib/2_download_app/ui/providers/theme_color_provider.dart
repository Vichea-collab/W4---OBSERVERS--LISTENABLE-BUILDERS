import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  green(color: Color.fromARGB(255, 229, 158, 221)),
  pink(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}

ThemeColor currentThemeColor = ThemeColor.pink;

class ThemeColorProvider extends ChangeNotifier {
  ThemeColor _themeColor = ThemeColor.pink;

  ThemeColor get themeColor => _themeColor;

  void updateThemeColor(ThemeColor themeColor) {
    if (_themeColor == themeColor) return;
    _themeColor = themeColor;
    currentThemeColor = themeColor;
    notifyListeners();
  }
}

final ThemeColorProvider themeColorProvider = ThemeColorProvider();
