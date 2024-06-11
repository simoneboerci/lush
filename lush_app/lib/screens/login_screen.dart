import 'package:flutter/material.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/registration_header.dart';

import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegistrationHeader(
            text: 'Accedi al tuo account',
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomForm(
                formKey: _formKey,
                textFields: [
                  CustomTextField.large(
                    hintText: 'La mia email',
                    onChanged: (value) {},
                  ),
                  CustomTextField.large(
                    hintText: 'La mia password',
                    onChanged: (value) {},
                  ),
                ],
                button: CustomElevatedButton(
                  padding: const EdgeInsets.only(top: 16.0),
                  text: 'Entra',
                  onPressed: () {},
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Oppure',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              CustomElevatedButton.google(
                text: 'Accedi con Google',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
