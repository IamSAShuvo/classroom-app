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

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: 14,
        ),
        backgroundColor: buttonBgColor,
        side: buttonBorderColor != null
            ? BorderSide(color: buttonBorderColor!)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonTextColor ?? AppColors.white,
          // fontSize: screenWidth * 0.04,
          fontSize: MediaQuery.textScalerOf(context).scale(16.0),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
