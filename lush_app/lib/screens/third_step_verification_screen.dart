import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';

class ThirdStepVerificationScreen extends StatelessWidget {
  ThirdStepVerificationScreen({super.key});

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
                    hintText: 'Il mio codice fiscale',
                  ),
                ],
                button: CustomElevatedButton.variant(
                  padding: const EdgeInsets.only(top: 16.0),
                  text: 'Richiedi Verifica',
                  onPressed: () {},
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 36.0),
                child: Text(
                  'Passaggio 3 di 3',
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
