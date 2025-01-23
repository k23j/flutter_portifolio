import 'package:flutter/material.dart';
import 'package:flutter_portifolio/appearance.dart';
import 'package:flutter_portifolio/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: MainScreen(),
    );
  }
}
