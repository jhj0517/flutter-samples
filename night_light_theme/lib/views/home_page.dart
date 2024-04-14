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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Light/Night Theme Sample",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        elevation: 4.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              themeProvider.attrs.name,
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20),
            Icon(
              themeProvider.attrs.icon,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Toggle Theme'),
              onPressed: () async {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
