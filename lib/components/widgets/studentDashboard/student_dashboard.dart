import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<StudentDashboard> {
  List<dynamic> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    const String apiUrl =
        'http://10.0.2.2:8080/course/all'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          courses = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception: $e')),
      );
    }
  }

  void navigateToSeeAll() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllScreen(courses: courses)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (courses.isNotEmpty) CourseCard(course: courses.first),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: navigateToSeeAll,
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Classwork',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation bar actions
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({required this.course});

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

class SeeAllScreen extends StatelessWidget {
  final List<dynamic> courses;

  const SeeAllScreen({required this.courses});

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
