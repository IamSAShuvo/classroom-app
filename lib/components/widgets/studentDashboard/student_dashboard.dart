import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/widgets/courseCard/course_card.dart';
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:classroom_app/components/widgets/seeAllCourses/see_all_courses.dart';

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
    const String apiUrl = 'http://10.0.2.2:8080/dashboard';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          setState(() {
            courses = responseBody['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseBody['message']}')),
          );
        }
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
        SnackBar(content: Text('Exception, I am from here: $e')),
      );
    }
  }

  // void navigateToSeeAll() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => SeeAllCourses(courses: courses)),
  //   );
  // }

  void navigateToSeeAll() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllCourses()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
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
                if (courses.isNotEmpty) CourseCard(course: courses.first),
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
