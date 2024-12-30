import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'] ?? course['courseTitle'] ?? 'Course Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Course Teacher - ${course['teacherName'] is String ? course['teacherName'] : (course['teacherName'] is List && course['teacherName'].isNotEmpty ? course['teacherName'][0]['name'] : (course['nameOfTeacher'] ?? 'Unknown'))}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Book List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              course['books']?.length ?? 0,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${index + 1}. ${course['books'][index]['name']} (Author: ${course['books'][index]['author']})',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const Divider(height: 20),
            const Text(
              'Uploaded Files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              course['uploadedFiles']?.length ?? 0,
              (index) => ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(course['uploadedFiles'][index]['fileName'] ?? ''),
                trailing: const Icon(Icons.file_download),
                onTap: () {
                  // Add logic to download the file
                },
              ),
            ),
            const Divider(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Add class comment',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
