import 'package:flutter/material.dart';
import 'package:classroom_app/styles/color/colors.dart';
import 'package:classroom_app/widgets/CustomButton/custom_button.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.black38),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/overviewPage_image.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Make Professional\nYour study plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.homeScreenHeadingColor,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Study according to the\nstudy plan, make study\nmore motivated',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: AppColors.classroomSecondaryColor,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: CustomButton(
                        buttonText: 'Sign Up',
                        buttonBgColor: AppColors.btnSecondaryColor,
                        buttonTextColor: AppColors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CustomButton(
                        buttonText: 'Log in',
                        buttonBgColor: AppColors.white,
                        buttonTextColor: AppColors.btnSecondaryColor,
                        buttonBorderColor: AppColors.btnSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
