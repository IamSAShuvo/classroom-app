import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:classroom_app/components/styles/color/colors.dart';
import 'package:classroom_app/components/widgets/CustomButton/custom_button.dart';
import 'package:classroom_app/components/widgets/SignUpScreen/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxHeight < 600;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top spacing or logo section
                if (!isSmallScreen)
                  SizedBox(height: constraints.maxHeight * 0.1),
                if (isSmallScreen) const Spacer(),
                // Title
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
                    color: AppColors.classroomSecondaryColor,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                // Input Fields
                Expanded(
                  flex: isSmallScreen ? 8 : 10,
                  child: ListView(
                    physics: isSmallScreen
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Profession Selection
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
                      CustomButton(
                        buttonText: 'Login',
                        buttonBgColor: AppColors.btnSecondaryColor,
                        buttonTextColor: AppColors.white,
                        onPressed: () {},
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
                                  color: AppColors.btnSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
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
