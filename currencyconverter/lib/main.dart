import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Text(
        "Santosh Bhandari",
        style: TextStyle(fontSize: 16, color: Color(222222)),
      ),
    ));
  }
}
