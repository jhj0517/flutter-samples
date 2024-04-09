import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'views/home_page.dart';
import 'localdb/my_db.dart';

void main() {
  runApp(
      const App()
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyDB>(
          create: (context) => MyDB(),
        ),
      ],
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
      ),
    );
  }
}

