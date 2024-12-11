import 'package:flutter/material.dart';
import 'package:classroom_app/components/styles/color/colors.dart';
import 'package:classroom_app/components/widgets/HomeScreen/home_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.classroomColor),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}
