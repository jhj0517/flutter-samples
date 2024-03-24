import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../providers/social_auth_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late SocialAuthProvider authProvider;

  @override
  void initState() {
    authProvider = context.read<SocialAuthProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Logins'), // Replace with your app name
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSignInUI(),
            const SizedBox(height: 30),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {
                await authProvider.handleGoogleSignIn();
              },
            ),
            const SizedBox(height: 30),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.apple,
              onPressed: () async {
                await authProvider.handleAppleSignIn();
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Place your sign-out logic here
                await authProvider.handleSignOut(); // Assuming authProvider has a signOut method
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInUI(){
    return Consumer<SocialAuthProvider>(
      builder: (context, authProvider, child) {
        final AuthStatus signInStatus = authProvider.status;
        final User? user = authProvider.currentUser;

        if (signInStatus == AuthStatus.authenticating){
          return const CircularProgressIndicator(
            color: Colors.purple,
          );
        }

        if (user == null){
          return const Text(
            "You are not signed-in.",
            style: TextStyle(fontSize: 20),
          );
        }

        return Text(
          "You are signed-in.\n"
          "Name : ${user.displayName}\n"
          "Email : ${user.email}",
          style: const TextStyle(fontSize: 15),
        );
      },
    );
  }
}
