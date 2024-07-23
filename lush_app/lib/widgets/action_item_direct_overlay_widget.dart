import 'package:flutter/material.dart';

class ActionItemDirectOverlayWidget extends StatelessWidget {
  const ActionItemDirectOverlayWidget({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.borderRadius = 16.0,
    this.textPadding =
        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    this.textFontSize = 15.0,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.addDivider = true,
  });

  final String label;
  final IconData icon;
  final Function()? onTap;
  final double borderRadius;
  final EdgeInsets textPadding;
  final double? textFontSize;
  final Color? textColor;
  final Color? iconColor;
  final double? iconSize;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: textPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: textFontSize,
                    color: textColor,
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                ),
              ],
            ),
          ),
        ),
        if (addDivider)
          const Divider(color: Colors.black26)
        else
          const Divider(color: Colors.transparent),
      ],
    );
  }
}
