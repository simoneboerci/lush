import 'package:flutter/material.dart';

import 'package:lush_app/core/constants/colors.dart';

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
    this.iconSize,
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
    this.iconSize,
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
    this.iconSize,
  });

  final EdgeInsets padding;
  final Function()? onPressed;
  final Color? iconColor;
  final IconData icon;
  final EdgeInsets? iconMargin;
  final Color? backgroundColor;
  final Color borderColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        iconSize: iconSize,
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
