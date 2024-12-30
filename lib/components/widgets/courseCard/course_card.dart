import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:classroom_app/components/widgets/courseDetailsScreen/course_details_screen.dart';

class CourseCard extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  late bool isEnrolled;
  late int numberOfStudentsEnrolled;

  @override
  void initState() {
    super.initState();
    isEnrolled = widget.course['studentEnrolled'] ?? false;
    numberOfStudentsEnrolled = widget.course['numberOfStudentsEnrolled'] ?? 0;
  }

  Future<void> enrollStudent(int courseId, BuildContext context) async {
    const String apiUrl = 'http://10.0.2.2:8080/course/enroll';
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
          setState(() {
            isEnrolled = true;
            numberOfStudentsEnrolled += 1;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Enrollment Successful'),
                content: const Text(
                  'You have successfully enrolled in the course.',
                ),
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseBody['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to enroll: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsScreen(
              course: widget.course,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.course['title'] ??
                    widget.course['courseTitle'] ??
                    'Course Title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.course['section'] ?? 'Section A',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                'Course Teacher - ${widget.course['teacherName'] is String ? widget.course['teacherName'] : (widget.course['teacherName'] is List && widget.course['teacherName'].isNotEmpty ? widget.course['teacherName'][0]['name'] : (widget.course['nameOfTeacher'] ?? 'Unknown'))}',
                style: const TextStyle(fontSize: 14),
              ),
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Book List',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Author',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ...List.generate(
                          widget.course['books']?.length ?? 0,
                          (index) => Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${index + 1}. ${widget.course['books'][index]['name']}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.025),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  widget.course['books'][index]['author'],
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$numberOfStudentsEnrolled person${numberOfStudentsEnrolled == 1 ? '' : 's'} Enrolled',
                    style: const TextStyle(
                      color: Color(0xFF6BD65A),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (widget.course.containsKey('studentEnrolled'))
                    isEnrolled
                        ? const Icon(
                            // Icons.show_chart,
                            // color: Colors.grey,
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              print(
                                  'Enroll button clicked for course: ${widget.course['courseId']}');
                              if (widget.course['courseId'] != null &&
                                  widget.course['courseId'] is int) {
                                await enrollStudent(
                                    widget.course['courseId'], context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid course ID'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Click to Enroll',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
