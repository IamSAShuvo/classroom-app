import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:classroom_app/components/styles/color/colors.dart';
import 'package:classroom_app/components/widgets/TextWidget/text_widget.dart';
import 'package:classroom_app/components/widgets/CustomButton/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

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
                child: SvgPicture.asset(
                  'assets/images/welcomeScreenImage.svg',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              textWidget(
                text: 'Make Professional\nYour study plan',
                fontSize: screenWidth * 0.06,
                color: AppColors.homeScreenHeadingColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              textWidget(
                text:
                    'Study according to the\nstudy plan, make study\nmore motivated',
                fontSize: screenWidth * 0.04,
                color: AppColors.classroomSecondaryColor,
              ),
              SizedBox(
                height: screenHeight * 0.1875,
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
