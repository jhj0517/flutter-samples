import 'package:flutter/material.dart';
import 'package:night_light_theme/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/home_page.dart';


Future<SharedPreferences> _initSharedPreference() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await SharedPreferences.getInstance();
}

Future<void> main() async {
  final prefs = await _initSharedPreference();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
    required this.prefs,
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
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Light/Night Theme Sample',
            theme: themeProvider.attrs.colors,
            home: const MyHomePage(),
          );
        },
      )
    );
  }
}

