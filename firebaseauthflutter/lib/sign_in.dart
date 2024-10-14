import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebaseauthflutter/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = auth.FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn) {
      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        // No return statement needed here
      });
    }
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
