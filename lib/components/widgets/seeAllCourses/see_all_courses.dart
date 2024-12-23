import 'package:flutter/material.dart';
import 'package:classroom_app/components/widgets/courseCard/course_card.dart';

class SeeAllCourses extends StatelessWidget {
  final List<dynamic> courses;

  const SeeAllCourses({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Courses'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}
