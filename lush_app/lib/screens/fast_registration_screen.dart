import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> _loginAnonymously(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInAnonymously();
        String userId = userCredential.user!.uid;
        LushUser user = LushUser(userId: userId, username: username);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set(user.toMap());
        Navigator.pushNamed(
          context,
          '/complete_registration_screen',
        );
      } catch (e) {
        print('Errore durante la registrazione: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
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
                  onPressed: () => _loginAnonymously(context),
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
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
