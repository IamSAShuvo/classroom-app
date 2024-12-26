import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/widgets/courseCard/course_card.dart';
import 'package:classroom_app/components/utils/global_authorization_token.dart';
import 'package:classroom_app/components/widgets/seeAllCourses/see_all_courses.dart';

class Dashboard extends StatefulWidget {
  final String title;
  final String userRole;
  final bool showFab;
  final VoidCallback? onFabPressed;

  const Dashboard({
    super.key,
    required this.title,
    required this.userRole,
    this.showFab = false,
    this.onFabPressed,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> courses = [];
  bool isLoading = true;
  String? teacherName;

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
            teacherName = extractTeacherName(responseBody['message']);
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
        SnackBar(content: Text('Exception: $e')),
      );
    }
  }

  void navigateToSeeAll() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllCourses()),
    );
  }

  String? extractTeacherName(String? message) {
    if (message == null || !message.contains('Name:')) {
      return null;
    }

    final parts = message.split('Name:');
    return parts.length > 1 ? parts[1].trim() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open drawer
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_sharp),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (widget.userRole != 'teacher')
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
                if (courses.isNotEmpty)
                  ...courses.map(
                    (course) => CourseCard(
                      course: {
                        ...course,
                        'nameOfTeacher': teacherName,
                      },
                    ),
                  )
                else
                  const Center(
                    child: Text('No courses available'),
                  ),
              ],
            ),
      floatingActionButton: widget.userRole == 'teacher'
          ? FloatingActionButton(
              onPressed: widget.onFabPressed,
              child: const Icon(Icons.add),
            )
          : null,
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
        onTap: (index) {},
      ),
    );
  }
}
