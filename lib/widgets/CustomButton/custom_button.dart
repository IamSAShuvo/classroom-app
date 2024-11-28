import 'package:flutter/material.dart';

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
    return SizedBox(
      // width: double.infinity,
      height: 56,
      width: 180,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
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
            color: buttonTextColor ?? Colors.white,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
