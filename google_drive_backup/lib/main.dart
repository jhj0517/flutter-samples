import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'views/home_page.dart';
import 'providers/g_drive_provider.dart';
import 'firebase_options.dart';

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async{
  await _initFirebase();
  runApp(
      Phoenix(
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GDriveProvider>(
          create: (context) => GDriveProvider(
            googleSignIn: GoogleSignIn(
              scopes: [
                'email',
                'https://www.googleapis.com/auth/drive',
              ],
            )
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
