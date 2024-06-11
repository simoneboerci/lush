import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = kSecondaryColor,
    this.minimumSize = const Size.fromHeight(60.0),
    this.onPressed,
    this.text = '',
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18.0,
  });

  final EdgeInsets padding;
  final Color? backgroundColor;
  final Size? minimumSize;
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: minimumSize,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Playfair Display',
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
