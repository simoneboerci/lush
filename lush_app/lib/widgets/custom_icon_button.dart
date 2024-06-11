import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
    this.iconColor = Colors.white,
    required this.icon,
    this.iconMargin,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
  });

  const CustomIconButton.large({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
    this.iconColor = Colors.white,
    required this.icon,
    this.iconMargin = const EdgeInsets.all(28.0),
    this.backgroundColor = const Color(0xFF333333),
    this.borderColor = cSecondaryColor,
  });

  const CustomIconButton.small({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
    this.iconColor = Colors.white,
    required this.icon,
    this.iconMargin,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
  });

  final EdgeInsets padding;
  final Function()? onPressed;
  final Color? iconColor;
  final IconData icon;
  final EdgeInsets? iconMargin;
  final Color? backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        style: IconButton.styleFrom(
          side: BorderSide(
            color: borderColor,
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        color: iconColor,
        icon: Icon(icon),
        padding: iconMargin,
      ),
    );
  }
}
