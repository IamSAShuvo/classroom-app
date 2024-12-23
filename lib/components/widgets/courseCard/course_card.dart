import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'] ?? 'Course Title',
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
              'Course Teacher - ${course['teacher'] ?? 'Unknown'}',
              style: const TextStyle(fontSize: 14),
            ),
            const Divider(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Book List',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...List.generate(
                        course['books']?.length ?? 0,
                        (index) => Text(
                            '${index + 1}. ${course['books'][index]['title']}'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Author',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...List.generate(
                        course['books']?.length ?? 0,
                        (index) => Text(course['books'][index]['author']),
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
                  '${course['enrolled']} person Enrolled',
                  style: const TextStyle(color: Colors.green),
                ),
                const Icon(Icons.show_chart, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
