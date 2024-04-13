import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeProvider(){}

  ThemeData _theme = ThemeColors.light;
  ThemeData get theme => _theme;

  ThemeAttrs _attrs = LightThemeAttrs();
  ThemeAttrs get attrs => _attrs;

  void toggleTheme() {
    bool isLight = _theme == ThemeColors.light;
    _theme = isLight ? ThemeColors.dark : ThemeColors.light;
    _attrs = isLight ? DarkThemeAttrs() : LightThemeAttrs();

    notifyListeners();
  }

}

class ThemeColors {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const  ColorScheme.light(
      background: Color(0xFFFFFFFF),
      primary: Color(0xFF000000),
      secondary: Color(0xFFE1A7FF),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF000000),
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFE1A7FF),
    ),
  );
}

// Attribute class for other things instead of colors
abstract class ThemeAttrs {
  String get themeName;
  IconData get themeIcon;
}

class LightThemeAttrs implements ThemeAttrs {
  @override
  String get themeName => "Light Theme";
  @override
  IconData get themeIcon => Icons.light_mode_outlined;
}

class DarkThemeAttrs implements ThemeAttrs {
  @override
  String get themeName => "Dark Theme";
  @override
  IconData get themeIcon => Icons.nights_stay;
}
