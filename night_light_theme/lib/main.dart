import 'package:flutter/material.dart';
import 'package:night_light_theme/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'views/home_page.dart';

Future<SharedPreferences> _initSharedPreference() async {
  return await SharedPreferences.getInstance();
}


Future<void> main() async {
  final SharedPreferences prefs = await _initSharedPreference();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.prefs
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(
            prefs: prefs
          )
        ),
      ],
      child: const MaterialApp(
        title: 'Light/Night Theme Sample',
        home: MyHomePage(),
      ),
    );
  }
}

