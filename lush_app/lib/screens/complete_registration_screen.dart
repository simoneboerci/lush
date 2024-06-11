import 'package:flutter/material.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_icon_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/view_models/complete_registration_view_model.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationViewModel(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: kBackgroundGradient,
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              CustomForm(
                formKey: _formKey,
                textFields: [
                  CustomTextField.large(
                      hintText: 'Il mio nome', onChanged: (value) {}),
                  CustomTextField.large(
                      hintText: 'Il mio username', onChanged: (value) {}),
                  CustomTextField.large(
                      hintText: 'La mia email', onChanged: (value) {}),
                  CustomTextField.large(
                      hintText: 'La mia password', onChanged: (value) {}),
                  CustomTextField.large(
                      hintText: 'Conferma password', onChanged: (value) {}),
                ],
                button: CustomElevatedButton(
                  padding: const EdgeInsets.only(top: 16.0),
                  text: 'Completa Profilo',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Clicca qui per inserire\nla tua immagine profilo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Image(
              width: 50,
              image: kArrowImage,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Image(
                    image: kLightPinkLogo,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 66.0,
                  ),
                  CustomIconButton.large(
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ],
              ),
              const Text(
                'Completa il tuo\nprofilo per cotinuare',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
