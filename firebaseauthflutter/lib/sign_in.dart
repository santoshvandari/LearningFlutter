import 'package:firebaseauthflutter/profile_page.dart';
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
      body: SignInScreen(
        providers: authProvider,
        actions: [
          AuthStateChangeAction<SignedIn>(
            (context, state) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          AuthStateChangeAction<UserCreated>((context, state) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          })
        ],
      ),
    );
  }
}
