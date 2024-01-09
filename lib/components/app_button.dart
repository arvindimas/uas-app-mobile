import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;

  const AppButton({
    Key? key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Adjust padding
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16, // Adjust font size
              fontWeight: FontWeight.bold, // Adjust font weight
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4, // Add elevation for a subtle shadow
        ),
      ),
    );
  }
}
