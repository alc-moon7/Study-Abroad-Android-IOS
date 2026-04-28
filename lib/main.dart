import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Abroad',
      debugShowCheckedModeBanner: false,
      theme: StudyAbroadTheme.data,
      home: const SplashScreen(),
    );
  }
}
