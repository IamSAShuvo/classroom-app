import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:classroom_app/components/utils/global_authorization_token.dart';

class EnrolledStudentsScreen extends StatelessWidget {
  final int courseId;

  const EnrolledStudentsScreen({super.key, required this.courseId});

  Future<List<Map<String, dynamic>>> fetchEnrolledStudents() async {
    const String apiUrl = 'http://10.0.2.2:8080/course/enrolled/all-student';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'courseId': courseId}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          return List<Map<String, dynamic>>.from(responseBody['data']);
        } else {
          throw Exception(responseBody['message']);
        }
      } else {
        throw Exception('Failed to fetch students: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enrolled Students')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchEnrolledStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students enrolled.'));
          } else {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(student['studentName'][0]),
                  ),
                  title: Text(student['studentName']),
                  subtitle: Text('ID: ${student['studentId']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
