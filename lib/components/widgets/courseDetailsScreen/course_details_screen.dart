import 'dart:convert';
import 'package:classroom_app/components/widgets/studentDashboard/student_dashboard.dart';
import 'package:classroom_app/components/widgets/teacherDashboard/teacher_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:classroom_app/components/widgets/enrolledStudents/enrolled_students_screen.dart';

class CourseDetailsScreen extends StatefulWidget {
  final int courseId;
  final Map<String, dynamic> course;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
    required this.course,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  Map<String, dynamic>? courseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    const url = 'http://10.0.2.2:8080/course/details';

    print('courseId: ${widget.courseId}');
    print('course: ${widget.course}');

    if (authToken == null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication token is missing. Please log in.'),
        ),
      );
      return;
    }
// Placeholder icon
    try {
      print('Requesting course details...');
      print('API URL: $url');
      print('Authorization Token: $authToken');
      print('Request Body: ${widget.courseId}');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'courseId': widget.courseId}),
      );
      print('API Response: ${response.body}');
      print('HTTP Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          courseData = jsonDecode(response.body)['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to fetch course details: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  void _showDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : courseData == null
              ? const Center(child: Text('No course data available'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Title: ${courseData!['title'] ?? courseData!['courseTitle'] ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                widget.course['teacherAvatarUrl'] != null
                                    ? NetworkImage(
                                            widget.course['teacherAvatarUrl'])
                                        as ImageProvider
                                    : null,
                            child: widget.course['teacherAvatarUrl'] == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Course Teacher - ${widget.course['teacherName'] is String ? widget.course['teacherName'] : (widget.course['teacherName'] is List && widget.course['teacherName'].isNotEmpty ? widget.course['teacherName'][0]['name'] : (widget.course['nameOfTeacher'] ?? 'Unknown'))}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                              overflow: TextOverflow
                                  .ellipsis, // Prevents overflow if the name is too long.
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Book List',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(
                        courseData!['books']?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '${index + 1}. ${courseData!['books'][index]['name']} (Author: ${courseData!['books'][index]['author']})',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            String payloadBase64 = authToken!.split('.')[1];
            String decodedPayload = utf8
                .decode(base64Url.decode(base64Url.normalize(payloadBase64)));

            Map<String, dynamic> payloadMap = jsonDecode(decodedPayload);

            List<dynamic> roles = payloadMap['roles'] ?? [];
            String role = roles.isNotEmpty ? roles[0] : '';
            if (role == 'ROLE_TEACHER') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherDashboard(),
                ),
              );
            } else if (role == 'ROLE_STUDENT') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentDashboard(),
                ),
              );
            } else {
              _showDialog(
                title: 'Login Failed',
                message: 'Invalid role detected.',
              );
            }
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EnrolledStudentsScreen(courseId: widget.courseId),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Enrolled',
          ),
        ],
      ),
    );
  }
}
