import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';

class SecondStepVerificationScreen extends StatelessWidget {
  SecondStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 36.0),
                child: RegistrationHeader(
                  image: cLightLightBlueLogo,
                  text: 'Compila il form\nper verificare il tuo profilo',
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomForm(
                formKey: _formKey,
                textFields: const [
                  CustomTextField.large(
                    hintText: 'Il mio indirizzo di residenza',
                  ),
                  CustomTextField.large(
                    hintText: 'La mia nazionalità',
                  ),
                  CustomTextField.large(
                    hintText: 'La mia email',
                  ),
                  CustomTextField.large(
                    hintText: 'Il mio numero di telefono',
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
                  'Passaggio 2 di 3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
