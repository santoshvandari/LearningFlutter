import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = <AuthProvider>[
      EmailAuthProvider(),
      PhoneAuthProvider(),
    ];
    return Scaffold(
      body: SignInScreen(
        providers: authProvider,
      ),
    );
  }
}
