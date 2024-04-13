import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

enum Themes{
  light,
  dark
}

class ThemeProvider extends ChangeNotifier {

  ThemeProvider({
    required this.prefs
  }){
    _setTheme();
  }

  final SharedPreferences prefs;
  final initialTheme = Themes.light;

  Themes? _them;
  Themes? get theme => _them;

  ThemeColors get themeColors => _getThemeColors();

  void toggleTheme() {
    _them = _them == Themes.light ? Themes.dark : Themes.light;
    _saveTheme();
    notifyListeners();
  }

  void _setTheme() {
    int? themeIndex = prefs.getInt(AppConstants.themeKey);
    _them = themeIndex == null ? initialTheme : Themes.values[themeIndex];
  }

  void _saveTheme() {
    prefs.setInt(AppConstants.themeKey, _them!.index);
  }

  ThemeColors _getThemeColors() {
    return _them == Themes.light
        ? LightTheme()
        : DarkTheme();
  }

}

abstract class ThemeColors {
  Color get backgroundColor;
  Color get fontColor;
}

class LightTheme implements ThemeColors {
  @override
  Color get backgroundColor => const Color(0xffffffff);
  @override
  Color get fontColor => const Color(0xFF000000);
}

class DarkTheme implements ThemeColors {
  @override
  Color get backgroundColor => const Color(0xff000000);
  @override
  Color get fontColor => const Color(0xFFFFFFFF);
}
