import 'package:flutter/material.dart';

class ActionOverlayMenuItemViewModel {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsets textPadding;
  final double textFontSize;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final bool addDivider;

  const ActionOverlayMenuItemViewModel({
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

  Divider get divider => addDivider
      ? const Divider(color: Colors.black26)
      : const Divider(color: Colors.transparent);
}
