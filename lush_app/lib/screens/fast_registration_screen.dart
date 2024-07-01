import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';

import 'package:provider/provider.dart';

import '../services/user_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/registration_header.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

import '../models/lush_user.dart';

class FastRegistrationScreen extends StatelessWidget {
  FastRegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  Future<LushUser?> _loginAnonimously() async {
    if (_formKey.currentState!.validate()) {
      return await FirebaseHelper.loginAnonimously(_usernameController.text);
    }
    return null;
  }

  Future<LushUser?> _loginWithGoogle() async {
    LushUser? loggedUser = await FirebaseHelper.loginWithGoogle();

    return await FirebaseHelper.getUserWithUid(loggedUser!.userId);
  }

  void _onGoogleButtonPressed(BuildContext context) {
    _loginWithGoogle().then((user) {
      if (user != null) {
        _completeRegistration(context, user);
      }
    });
  }

  void _onPressed(BuildContext context) {
    _loginAnonimously().then((user) {
      if (user != null) {
        _completeRegistration(context, user);
      }
    });
  }

  void _completeRegistration(BuildContext context, LushUser user) {
    Navigator.pushNamed(context, '/complete_registration_screen');
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
                text: 'Registrazione veloce',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomForm(
                    formKey: _formKey,
                    textFields: [
                      CustomTextField.large(
                        hintText: 'Il mio username',
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Per favore, inserisci un username';
                          }
                          return null;
                        },
                      ),
                    ],
                    button: CustomElevatedButton(
                      padding: const EdgeInsets.only(top: 16.0),
                      text: 'Conferma',
                      onPressed: () => _onPressed(context),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Oppure',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomElevatedButton.google(
                    text: 'Registrati con Google',
                    onPressed: () => _onGoogleButtonPressed(context),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login_screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              foregroundColor: cPrimaryColor,
            ),
            child: const Text(
              'Accedi',
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
