import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ArtRevisionApp());
}

class ArtRevisionApp extends StatelessWidget {
  const ArtRevisionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Revision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
      home: const HomeScreen(),
    );
  }
}