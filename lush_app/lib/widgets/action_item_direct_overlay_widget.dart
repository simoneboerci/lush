import 'package:flutter/material.dart';

class ActionItemDirectOverlayWidget extends StatelessWidget {
  const ActionItemDirectOverlayWidget({
    super.key,
    this.onTap,
    this.borderRadius = 16.0,
    this.textPadding =
        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    required this.label,
    this.textFontSize = 15.0,
    this.textColor = Colors.white,
    required this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.addDivider = true,
  });

  final Function()? onTap;
  final double borderRadius;
  final EdgeInsets textPadding;
  final String label;
  final double textFontSize;
  final Color? textColor;
  final IconData icon;
  final Color? iconColor;
  final double iconSize;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
          ],
        ),
        addDivider
            ? const Divider(
                color: Colors.black26,
              )
            : const Divider(
                color: Colors.transparent,
              ),
      ],
    );
  }
}
