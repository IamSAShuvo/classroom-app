import 'package:flutter/material.dart';
import 'package:classroom_app/components/widgets/dashboard/dashboard.dart';
import 'package:classroom_app/components/widgets/createCourseScreen/create_course_screen.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      title: 'Classroom (Teacher)',
      userRole: 'teacher',
      showFab: true,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateCourseScreen()),
        );
      },
    );
  }
}
