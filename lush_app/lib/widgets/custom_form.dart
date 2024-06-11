import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/widgets/custom_text_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    required this.formKey,
    this.textFields = const <CustomTextField>[],
    this.buttonOnPressed,
    this.buttonBackgroundColor = kSecondaryColor,
    this.buttonSize = const Size.fromHeight(60.0),
    this.buttonText = '',
    this.buttonTextColor = Colors.white,
    this.buttonTextSize = 18.0,
    this.buttonMargin = const EdgeInsets.only(top: 16.0),
    this.buttonTextFontWeight = FontWeight.bold,
  });

  final EdgeInsets padding;
  final GlobalKey<FormState> formKey;
  final List<CustomTextField> textFields;
  final Function()? buttonOnPressed;
  final Color? buttonBackgroundColor;
  final Size buttonSize;
  final String buttonText;
  final Color? buttonTextColor;
  final double buttonTextSize;
  final EdgeInsets buttonMargin;
  final FontWeight buttonTextFontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ...textFields,
            Padding(
              padding: buttonMargin,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackgroundColor,
                  minimumSize: buttonSize,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    buttonOnPressed;
                  }
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontFamily: 'Playfair Display',
                    fontWeight: buttonTextFontWeight,
                    fontSize: buttonTextSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
