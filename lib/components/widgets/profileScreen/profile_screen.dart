import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_app/components/widgets/HomeScreen/home_screen.dart';
import 'package:classroom_app/components/utils/global_authorization_token.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String? roleOfUser;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final url = Uri.parse('http://10.0.2.2:8080/profile/details');

    if (authToken == null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Authentication token is missing. Please log in.')),
      );
      return;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          roleOfUser = extractRoleFromMessage(responseBody['message']);
          profileData = json.decode(response.body)['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to fetch profile details: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print('Error: $e');
    }
  }

  String? extractRoleFromMessage(String? message) {
    if (message == null || !message.contains('for the')) {
      return null;
    }

    final startIndex = message.indexOf('for the') + 'for the'.length;
    final endIndex = message.indexOf('.', startIndex);
    if (startIndex != -1 && endIndex != -1) {
      return message.substring(startIndex, endIndex).trim();
    }

    return null;
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
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileData == null
              ? const Center(child: Text('No profile data available'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: profileData!['imageUrl'] != null
                              ? NetworkImage(profileData!['imageUrl'])
                              : const AssetImage(
                                  'assets/images/profile_avatar.jpeg')),
                      const SizedBox(height: 10),
                      Text(
                        profileData!['name'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        roleOfUser ?? 'N/A',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileDetailRow(
                              title: 'Username',
                              value: profileData!['user']['username'] ?? 'N/A',
                            ),
                            ProfileDetailRow(
                              title: 'Email',
                              value: profileData!['user']['email'] ?? 'N/A',
                            ),
                            ProfileDetailRow(
                              title: 'Courses',
                              value: roleOfUser?.toLowerCase() == 'student'
                                  ? '${profileData!['courses']?.length ?? 0} Enrolled'
                                  : '${profileData!['courses']?.length ?? 0} Created',
                            ),
                            const SizedBox(height: 80),
                            ElevatedButton(
                              onPressed: () {
                                _logoutUser(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Align(
                                  child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const ProfileDetailRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
