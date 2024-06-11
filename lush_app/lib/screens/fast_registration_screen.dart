import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';
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
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: kBackgroundGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: cLightPinkLogo,
                        height: 50.0,
                      ),
                      Text(
                        'Registrazione veloce',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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
        ),
      ),
    );
  }
}
