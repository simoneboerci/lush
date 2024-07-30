import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';

class FormWidgetViewModel {
  final GlobalKey<FormState> formKey;
  final FormHeaderWidgetViewModel headerViewModel;
  final List<Widget> textFields;
  final EdgeInsets primaryButtonPadding;
  final String primaryButtonText;
  final VoidCallback? primaryButtonOnPressed;
  final Color primaryButtonBackgroundColor;
  final Color primaryButtonTextColor;
  final bool disablePrimaryButton;
  final bool useSecondaryButton;
  final EdgeInsets secondaryButtonPadding;
  final String secondaryButtonText;
  final VoidCallback? secondaryButtonOnPressed;
  final bool disableSecondaryButton;
  final bool useTextButton;
  final VoidCallback? textButtonOnPressed;
  final String textButtonText;
  final double textButtonFontSize;
  final bool disableTextButton;

  FormWidgetViewModel({
    required this.formKey,
    required this.headerViewModel,
    required this.textFields,
    this.primaryButtonPadding = const EdgeInsets.only(top: 16.0),
    required this.primaryButtonText,
    this.primaryButtonOnPressed,
    this.primaryButtonBackgroundColor = cPrimaryColor,
    this.primaryButtonTextColor = Colors.white,
    this.disablePrimaryButton = false,
    this.useSecondaryButton = false,
    this.secondaryButtonPadding = const EdgeInsets.all(16.0),
    this.secondaryButtonText = '',
    this.secondaryButtonOnPressed,
    this.disableSecondaryButton = false,
    this.useTextButton = false,
    this.textButtonOnPressed,
    this.textButtonText = '',
    this.textButtonFontSize = 18.0,
    this.disableTextButton = false,
  });
}
