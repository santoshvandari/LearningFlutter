import 'package:flutter/material.dart';
import 'package:shopapp/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ShoppingApp",
      theme: ThemeData(
          fontFamily: 'roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
          )),
      home: const HomePage(),
    );
  }
}
