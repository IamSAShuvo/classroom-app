import 'package:flutter/material.dart';
import 'package:classroom_app/styles/color/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonBgColor,
    this.buttonTextColor,
    this.buttonBorderColor,
  });

  final String buttonText;
  final Color buttonBgColor;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 56,
      width: screenWidth * 0.4,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: 14,
          ),
          backgroundColor: buttonBgColor,
          side: buttonBorderColor == null
              ? null
              : BorderSide(color: buttonBorderColor!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor ?? AppColors.white,
            fontSize: screenWidth * 0.04,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
