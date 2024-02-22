import 'package:flutter/material.dart';
import 'package:myfirstapp/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
