import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/widgets/HomeScreen/home_screen.dart';
import 'package:classroom_app/components/widgets/courseCard/course_card.dart';
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:classroom_app/components/widgets/profileScreen/edit_profile_screen.dart';
import 'package:classroom_app/components/widgets/studentDashboard/student_dashboard.dart';

class SeeAllCourses extends StatefulWidget {
  const SeeAllCourses({super.key});

  @override
  State<SeeAllCourses> createState() => _SeeAllCoursesState();
}

class _SeeAllCoursesState extends State<SeeAllCourses> {
  List<dynamic> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    const String apiUrl = 'http://10.0.2.2:8080/course/all';
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

  void navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentDashboard(),
      ),
    );
  }

  void _logoutUser(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.person_outline_sharp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              } else if (value == 1) {
                _logoutUser(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.edit, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Edit Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 40), // Adjust the position of the dropdown
          ),
        ],
      ),
      drawer: Drawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: courses[index]);
              },
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
          if (index == 0) {
            navigateToDashboard(); // Recreate dashboard on Home tap
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tab $index pressed')),
            );
          }
        },
      ),
    );
  }
}
