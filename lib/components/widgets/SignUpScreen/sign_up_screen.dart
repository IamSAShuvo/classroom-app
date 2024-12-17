import 'package:flutter/material.dart';
import '../CustomButton/custom_button.dart';
import 'package:classroom_app/components/styles/color/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int _selectedProfession = 1; // Default to Student
  bool _isTermsChecked = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

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
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.homeScreenHeadingColor,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Enter your details below & free sign up',
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
                        decoration: InputDecoration(
                          labelText: 'Name',
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
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Profession Selection
                      Text(
                        'Select Profession',
                        style: TextStyle(
                          color: AppColors.homeScreenHeadingColor,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              value: 1,
                              groupValue: _selectedProfession,
                              onChanged: (value) {
                                setState(() {
                                  _selectedProfession = value!;
                                });
                              },
                              title: const Text('Student'),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 2,
                              groupValue: _selectedProfession,
                              onChanged: (value) {
                                setState(() {
                                  _selectedProfession = value!;
                                });
                              },
                              title: const Text('Teacher'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomButton(
                        buttonText: 'Create account',
                        buttonBgColor: AppColors.btnSecondaryColor,
                        buttonTextColor: AppColors.white,
                        onPressed: () {},
                      ),
                      if (!isSmallScreen) SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Checkbox(
                            value: _isTermsChecked,
                            onChanged: (value) {
                              setState(() {
                                _isTermsChecked = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'By creating an account you have to agree with our terms & conditions.',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: screenWidth * 0.035),
                      children: const [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: AppColors.btnSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isSmallScreen) SizedBox(height: screenHeight * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}
