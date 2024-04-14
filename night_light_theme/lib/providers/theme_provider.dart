import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeProvider({
    required this.prefs
  }){
    _loadTheme();
  }

  final SharedPreferences prefs;

  ThemeAttrs _attrs = LightThemeAttrs();
  ThemeAttrs get attrs => _attrs;

  Future<void> toggleTheme() async {
    bool isLight = attrs.themeMode == ThemeModes.light;
    _attrs = isLight ? DarkThemeAttrs() : LightThemeAttrs();
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() {
    int? modeIndex = prefs.getInt(AppConstants.themeKey);
    ThemeModes mode = modeIndex == null ? ThemeModes.light : ThemeModes.values[modeIndex];
    _attrs = mode == ThemeModes.light ? LightThemeAttrs() : DarkThemeAttrs();
  }

  Future<void> _saveTheme() async {
    prefs.setInt(AppConstants.themeKey, attrs.themeMode.index);
  }

}

enum ThemeModes{
  light,
  dark
}

// Attribute class for other things instead of colors
abstract class ThemeAttrs {
  ThemeModes get themeMode;
  String get themeName;
  IconData get themeIcon;
  ThemeData get themeColors;
}

class LightThemeAttrs implements ThemeAttrs {
  @override
  ThemeModes get themeMode => ThemeModes.light;
  @override
  String get themeName => "Light Theme";
  @override
  IconData get themeIcon => Icons.light_mode_outlined;
  @override
  ThemeData get themeColors => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const  ColorScheme.light(
      background: Color(0xFFFFFFFF),
      primary: Color(0xFF000000),
      secondary: Color(0xFFE1A7FF),
    ),
  );
}

class DarkThemeAttrs implements ThemeAttrs {
  @override
  ThemeModes get themeMode => ThemeModes.dark;
  @override
  String get themeName => "Dark Theme";
  @override
  IconData get themeIcon => Icons.nights_stay;
  @override
  ThemeData get themeColors => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF000000),
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFE1A7FF),
    ),
  );
}
