import 'dart:convert';
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseTeacherController = TextEditingController();
  List<Map<String, TextEditingController>> bookControllers = [];

  @override
  void initState() {
    super.initState();
    addBookInputFields();
  }

  void addBookInputFields() {
    setState(() {
      bookControllers.add({
        'bookName': TextEditingController(),
        'authorName': TextEditingController(),
      });
    });
  }

  Future<void> createCourse() async {
    final courseTitle = courseNameController.text;

    final books = bookControllers.map((controllers) {
      return {
        'name': controllers['bookName']?.text ?? '',
        'author': controllers['authorName']?.text ?? '',
      };
    }).toList();

    final requestBody = {
      'courseTitle': courseTitle,
      'books': books,
    };

    const apiUrl = 'http://10.0.2.2:8080/course/create';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Course created successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    courseNameController.clear();
                    courseTeacherController.clear();
                    for (var controllers in bookControllers) {
                      controllers['bookName']?.clear();
                      controllers['authorName']?.clear();
                    }
                    // setState(() {
                    //   bookControllers.clear();
                    // });
                    // Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception: $e')),
      );
    }
  }

  @override
  void dispose() {
    courseNameController.dispose();
    courseTeacherController.dispose();
    for (var controllers in bookControllers) {
      controllers['bookName']?.dispose();
      controllers['authorName']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Course'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Name Input
            TextField(
              controller: courseNameController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                // border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Column(
              children: [
                ...bookControllers.map((controllers) {
                  return Column(
                    children: [
                      TextField(
                        controller: controllers['bookName'],
                        decoration: InputDecoration(
                          labelText: 'Book List',
                          // border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: controllers['authorName'],
                        decoration: const InputDecoration(
                          labelText: 'Author Name',
                          // border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            ),

            const SizedBox(height: 16),
            // Add Book Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: addBookInputFields,
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                  tooltip: 'Add Book',
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: createCourse,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
