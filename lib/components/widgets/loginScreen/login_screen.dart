import 'dart:convert';
import 'package:classroom_app/components/styles/color/colors.dart';
import 'package:classroom_app/components/widgets/SignUpScreen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Function to handle login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          // If login is successful, you can save the tokens or navigate
          print('Login Successful: ${data['data']['accessToken']}');
          // Handle navigation or token storage here
        } else {
          // Handle error message
          print('Login Failed: ${data['message']}');
        }
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      // Handle any error during the API request
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxHeight < 600;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSmallScreen)
                  SizedBox(height: constraints.maxHeight * 0.1),
                if (isSmallScreen) const Spacer(),
                Text(
                  'Log In',
                  style: TextStyle(
                    color: AppColors.homeScreenHeadingColor,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Enter your details below & free log in',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Expanded(
                  flex: isSmallScreen ? 8 : 10,
                  child: ListView(
                    physics: isSmallScreen
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Forgot PassWord?',
                        style: TextStyle(
                          color: AppColors.homeScreenHeadingColor,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(height: screenHeight * 0.32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor:
                              AppColors.btnSecondaryColor, // Text color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : _login, // Disable button during loading
                        child: _isLoading
                            ? const CircularProgressIndicator() // Show loading indicator
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to sign up screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isSmallScreen) SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
