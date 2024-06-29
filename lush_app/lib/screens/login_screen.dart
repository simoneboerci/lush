import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/models/lush_user.dart';
import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/registration_header.dart';

import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<LushUser?> _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      LushUser? loggedUser =
          await FirebaseHelper.loginWithEmailAndPassword(email, password);
      if (loggedUser != null) {
        return await FirebaseHelper.getUserWithUid(loggedUser.userId);
      }
    }

    return null;
  }

  Future<LushUser?> _loginWithGoogle() async {
    LushUser? loggedUser = await FirebaseHelper.loginWithGoogle();

    if (loggedUser != null) {
      return await FirebaseHelper.getUserWithUid(loggedUser.userId);
    }

    return null;
  }

  void _onGoogleButtonPressed(BuildContext context) {
    _loginWithGoogle().then((user) {
      if (user != null) {
        _completeLogin(context, user);
      }
    });
  }

  void _onPressed(BuildContext context) {
    _login().then((user) {
      if (user != null) {
        _completeLogin(context, user);
      }
    });
  }

  void _completeLogin(BuildContext context, LushUser user) {
    Navigator.pushReplacementNamed(context, '/first_step_verification_screen');
    Provider.of<UserProvider>(context, listen: false).setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 25.0,
          ),
          Column(
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
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Per favore, inserisci un email';
                          }
                          return null;
                        },
                      ),
                      CustomTextField.large(
                        hintText: 'La mia password',
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Per favore, inserisci una password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                    ],
                    button: CustomElevatedButton(
                      padding: const EdgeInsets.only(top: 16.0),
                      text: 'Entra',
                      onPressed: () => _onPressed(context),
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
                    onPressed: () => _onGoogleButtonPressed(context),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/fast_registration_screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              foregroundColor: cPrimaryColor,
            ),
            child: const Text(
              'Registrati',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
