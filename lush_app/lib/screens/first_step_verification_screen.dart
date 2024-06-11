import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';

class FirstStepVerificationScreen extends StatelessWidget {
  FirstStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 36.0),
            child: RegistrationHeader(
              showButton: true,
              image: cLightLightBlueLogo,
              text: 'Compila il form\nper verificare il tuo profilo',
            ),
          ),
          CustomForm(
            formKey: _formKey,
            textFields: const [
              CustomTextField.large(
                hintText: 'Il mio nome',
              ),
              CustomTextField.large(
                hintText: 'Il mio cognome',
              ),
              CustomTextField.large(
                hintText: 'La mia data di nascita',
              ),
              CustomTextField.large(
                hintText: 'Il mio luogo di nascita',
              ),
            ],
            button: CustomElevatedButton.variant(
              padding: const EdgeInsets.only(top: 16.0),
              text: 'Procedi',
              onPressed: () {},
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 36.0),
            child: Text(
              'Passaggio 1 di 3',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
