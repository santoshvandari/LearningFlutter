import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebaseauthflutter/sign_in.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = [EmailAuthProvider()];
    return ProfileScreen(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      providers: provider,
      showMFATile: true,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        }),
        AccountDeletedAction((context, user) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        })
      ],
    );
  }
}
