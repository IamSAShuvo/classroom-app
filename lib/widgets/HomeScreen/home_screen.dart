import 'package:classroom_app/widgets/CustomButton/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/overviewPage_image.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Make Professional\nYour study plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1f1f39),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Study according to the\nstudy plan, make study\nmore motivated',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: Color(0xff858597),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  buttonText: 'Sign Up',
                  buttonBgColor: Color(0xFF5177FF),
                  buttonTextColor: Colors.white,
                ),
                CustomButton(
                  buttonText: 'Log in',
                  buttonBgColor: Colors.white,
                  buttonTextColor: Color(0xFF5177FF),
                  buttonBorderColor: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
