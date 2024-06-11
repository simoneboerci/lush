import 'package:flutter/material.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/registration_header.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

import 'package:lush_app/models/fast_registration_view_model.dart';

class FastRegistrationScreen extends StatelessWidget {
  FastRegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FastRegistrationViewModel(),
      child: CustomBackground(
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
                      onChanged: (value) {},
                    ),
                  ],
                  button: CustomElevatedButton(
                    padding: const EdgeInsets.only(top: 16.0),
                    text: 'Conferma',
                    onPressed: () {},
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
      ),
    );
  }
}
