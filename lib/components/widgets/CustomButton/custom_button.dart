import 'package:flutter/material.dart';
import 'package:classroom_app/components/styles/color/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonBgColor,
    this.buttonTextColor,
    this.buttonBorderColor,
    this.onPressed,
  });

  final String buttonText;
  final Color buttonBgColor;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const double defaultBorderRadius = 5;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: 14,
        ),
        backgroundColor: buttonBgColor,
        shape: RoundedRectangleBorder(
          side: buttonBorderColor != null
              ? BorderSide(color: buttonBorderColor!)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonTextColor ?? AppColors.white,
          fontSize: MediaQuery.textScalerOf(context).scale(16.0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
