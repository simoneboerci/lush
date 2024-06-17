import 'package:flutter/material.dart';

import 'package:lush_app/widgets/registration_header.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passowrdConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    String password = '';

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
                hintText: 'Il mio nome',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci il tuo nome';
                  }
                  return null;
                },
              ),
              CustomTextField.large(
                hintText: 'Il mio username',
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci il tuo username';
                  }
                  return null;
                },
              ),
              CustomTextField.large(
                hintText: 'La mia email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci la tua email';
                  }
                  return null;
                },
              ),
              CustomTextField.large(
                hintText: 'La mia password',
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci la tua password';
                  } else {
                    password = value;
                  }
                  return null;
                },
              ),
              CustomTextField.large(
                hintText: 'Conferma password',
                controller: _passowrdConfirmationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, conferma la tua password';
                  }
                  if (value != password) {
                    return 'Le password non corrispondono';
                  }
                  return null;
                },
              ),
            ],
            button: CustomElevatedButton(
              padding: const EdgeInsets.only(top: 16.0),
              text: 'Completa Profilo',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(
                      context, '/first_step_verification_screen');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
