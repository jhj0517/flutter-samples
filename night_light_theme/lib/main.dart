import 'package:flutter/material.dart';
import 'package:night_light_theme/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'views/home_page.dart';


void main() {
  final SharedPreferences prefs = await _initSharedPreference();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(  )
          ),
        ),
      ],
      child: const MaterialApp(
        title: 'Google Drive Backup',
        home: MyHomePage(),
      ),
    );
  }
}

