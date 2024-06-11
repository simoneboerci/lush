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
    this.fontFamily = 'Playfair Display',
    this.googleButton = false,
  });

  const CustomElevatedButton.google({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = Colors.white,
    this.minimumSize = const Size.fromHeight(60.0),
    this.onPressed,
    this.text = '',
    this.textColor = const Color(0xFF121212),
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.fontFamily = 'Roboto',
    this.googleButton = true,
  });

  final EdgeInsets padding;
  final Color? backgroundColor;
  final Size? minimumSize;
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String? fontFamily;
  final bool googleButton;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            googleButton
                ? const Image(
                    width: 28.0,
                    image: kGoogleIconImage,
                  )
                : Container(),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
            googleButton ? const SizedBox(width: 28.0) : Container(),
          ],
        ),
      ),
    );
  }
}
