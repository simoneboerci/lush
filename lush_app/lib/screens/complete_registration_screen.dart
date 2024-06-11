import 'package:flutter/material.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/registration_header.dart';

import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RegistrationHeader(
            showButton: true,
          ),
          CustomForm(
            formKey: _formKey,
            textFields: [
              CustomTextField.large(
                  hintText: 'Il mio nome', onChanged: (value) {}),
              CustomTextField.large(
                  hintText: 'Il mio username', onChanged: (value) {}),
              CustomTextField.large(
                  hintText: 'La mia email', onChanged: (value) {}),
              CustomTextField.large(
                  hintText: 'La mia password', onChanged: (value) {}),
              CustomTextField.large(
                  hintText: 'Conferma password', onChanged: (value) {}),
            ],
            button: CustomElevatedButton(
              padding: const EdgeInsets.only(top: 16.0),
              text: 'Completa Profilo',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
