import 'package:flutter/material.dart';

import 'package:lush_app/widgets/custom_elevated_button.dart';

import 'package:lush_app/widgets/custom_text_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    required this.formKey,
    required this.textFields,
    required this.button,
  });

  final EdgeInsets padding;
  final GlobalKey<FormState> formKey;
  final List<CustomTextField> textFields;
  final CustomElevatedButton button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ...textFields,
            button,
          ],
        ),
      ),
    );
  }
}
