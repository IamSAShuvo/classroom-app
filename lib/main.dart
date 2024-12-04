import 'package:classroom_app/widgets/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClassroomApp());
}

class ClassroomApp extends StatelessWidget {
  const ClassroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synergy Classroom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5F5F5)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
