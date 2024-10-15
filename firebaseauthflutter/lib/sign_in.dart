import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = <AuthProvider>[
      EmailAuthProvider(),
      // PhoneAuthProvider(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
      body: SignInScreen(
        providers: authProvider,
        actions: [
          AuthStateChangeAction<SignedIn>(
            (context, state) {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          AuthStateChangeAction<UserCreated>((context, state) {
            Navigator.pushReplacementNamed(context, '/profile');
          })
        ],
      ),
    );
  }
}
