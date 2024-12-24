import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    // final screenHeight = size.height;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'] ?? course['courseTitle'] ?? 'Course Title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              course['section'] ?? 'Section A',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Course Teacher - ${course['teacherName'] is String ? course['teacherName'] : (course['teacherName'] is List && course['teacherName'].isNotEmpty ? course['teacherName'][0]['name'] : (course['nameOfTeacher'] ?? 'Unknown'))}',
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
                        course['books']?.length ?? 0,
                        (index) => Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${index + 1}. ${course['books'][index]['name']}',
                                style: TextStyle(fontSize: screenWidth * 0.025),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                course['books'][index]['author'],
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
                  '${course['numberOfStudentsEnrolled'] ?? '0'} person Enrolled',
                  style: const TextStyle(
                    color: Color(0xFF6BD65A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                course['studentEnrolled'] == true
                    ? const Icon(
                        Icons.show_chart,
                        color: Colors.grey,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          // Handle enrollment action here
                          print(
                              'Enroll button clicked for course: ${course['courseTitle']}');
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
    );
  }
}
