import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'providers/social_auth_provider.dart';
import 'views/home_page.dart';
import 'firebase_options.dart';

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  await _initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocialAuthProvider>(
          create: (context) => SocialAuthProvider(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn()
          ),
        ),
      ],
      child: MaterialApp(
        home: const MyHomePage(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
      ),
    );
  }
}