import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ThemeProvider themeProvider;

  @override
  void initState() {
    themeProvider = context.read<ThemeProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = context.watch<ThemeProvider>();
    final attrs = themeProvider.themeAttrs;
    return Scaffold(
      backgroundColor: attrs.backgroundColor,
      appBar: AppBar(
        backgroundColor: attrs.backgroundColor,
        title: Text(
          "Light/Night Theme Sample",
          style: TextStyle(color: attrs.fontColor),
        ),
        elevation: 4.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              attrs.themeName,
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  color: attrs.fontColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20),
            Icon(
              attrs.themeIcon,
              size: 100,
              color: attrs.fontColor,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Toggle Theme'),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
