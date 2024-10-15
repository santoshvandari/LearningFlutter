import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = [EmailAuthProvider()];
    return ProfileScreen(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      providers: provider,
      showMFATile: true,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/signin');
        }),
        AccountDeletedAction((context, user) {
          Navigator.pushReplacementNamed(context, '/signin');
        })
      ],
    );
  }
}
