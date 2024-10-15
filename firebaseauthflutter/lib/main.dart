import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauthflutter/firebase_options.dart';
import 'package:firebaseauthflutter/profile_page.dart';
import 'package:firebaseauthflutter/sign_in.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userStatus = FirebaseAuth.instance.currentUser != null;
    final initialRoute = userStatus ? "/profile" : "/signin";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        "/signin": (context) => const SignIn(),
        "/profile": (context) => const ProfilePage(),
      },
    );
  }
}
