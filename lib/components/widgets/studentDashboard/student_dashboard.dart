import 'package:flutter/material.dart';
import 'package:classroom_app/components/widgets/dashboard/dashboard.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      title: 'Classroom (Student)',
      userRole: 'student', // Specify the role
      showFab: false, // No floating button for students
    );
  }
}
