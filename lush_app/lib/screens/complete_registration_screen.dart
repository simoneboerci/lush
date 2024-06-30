import 'package:flutter/material.dart';
import 'package:lush_app/models/lush_user.dart';
import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/registration_header.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passowrdConfirmationController =
      TextEditingController();

  Future<LushUser?> _completeRegistration() async {
    if (_formKey.currentState!.validate()) {
      try {
        String email = _emailController.text;
        String password = _passwordController.text;

        LushUser? loggedUser =
            await FirebaseHelper.registerWithEmailAndPassword(email, password);

        if (loggedUser != null) {
          LushUser updatedUser = LushUser.copyWith(
            user: loggedUser,
            name: _nameController.text,
            username: _usernameController.text,
          );

          await FirebaseHelper.storeUserData(updatedUser);

          return updatedUser;
        }
      } catch (e) {
        print('Errore durante il completamento della registrazione: $e');
      }
    }
    return null;
  }

  void _onPressed(BuildContext context) {
    _completeRegistration().then((user) {
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(
            context, '/first_step_verification_screen');
      }
    });
  }

  void _updateTextFieldTextsBasedOnUser(BuildContext context) {
    LushUser? currentUser =
        Provider.of<UserProvider>(context, listen: false).user;

    if (currentUser != null) {
      _usernameController.text = currentUser.username ?? '';
      _nameController.text = currentUser.name ?? '';
      _emailController.text = currentUser.email ?? '';
      _passwordController.text = currentUser.password ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTextFieldTextsBasedOnUser(context);

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
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, inserisci la tua password';
                  }
                  return null;
                },
              ),
              CustomTextField.large(
                hintText: 'Conferma password',
                controller: _passowrdConfirmationController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Per favore, conferma la tua password';
                  }
                  if (value != _passwordController.text) {
                    return 'Le password non corrispondono';
                  }
                  return null;
                },
              ),
            ],
            button: CustomElevatedButton(
              padding: const EdgeInsets.only(top: 16.0),
              text: 'Completa Profilo',
              onPressed: () => _onPressed(context),
            ),
          ),
        ],
      ),
    );
  }
}
