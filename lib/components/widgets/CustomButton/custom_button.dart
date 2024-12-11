import 'package:flutter/material.dart';
import 'package:classroom_app/components/styles/color/colors.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    const double defaultBorderRadius = 5;

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
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonTextColor ?? AppColors.white,
          fontSize: MediaQuery.textScalerOf(context).scale(16.0),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
