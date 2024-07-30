import 'package:flutter/material.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';

class FormHeaderWidgetViewModel {
  final EdgeInsets padding;
  final LogoType logoType;
  final double arrowImageSize;
  final String hintText;
  final Color hintTextColor;
  final String text;
  final Color textColor;
  final double textFontSize;
  final VoidCallback? onPressed;
  final bool showButton;

  const FormHeaderWidgetViewModel({
    this.padding = const EdgeInsets.symmetric(horizontal: 26.0, vertical: 4.0),
    this.logoType = LogoType.lightPink,
    this.arrowImageSize = 50.0,
    this.hintText = '',
    this.hintTextColor = Colors.white,
    required this.text,
    this.textColor = Colors.white,
    this.textFontSize = 18.0,
    this.onPressed,
    this.showButton = false,
  });
}
