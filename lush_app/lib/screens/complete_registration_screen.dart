import 'package:flutter/material.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/view_models/complete_registration_view_model.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
              _buildForm(),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    minimumSize: const Size.fromHeight(60)),
                onPressed: () {},
                child: const Text(
                  'Completa Profilo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                        border: Border.all(color: kAccentColor, width: 1)),
                    child: IconButton(
                      onPressed: () {},
                      color: Colors.white,
                      icon: const Icon(Icons.add),
                      padding: const EdgeInsets.all(28),
                    ),
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

  Widget _buildForm() {
    return Column(
      children: [
        CustomTextField.large(hintText: 'Il mio nome', onChanged: (value) {}),
        CustomTextField.large(
            hintText: 'Il mio username', onChanged: (value) {}),
        CustomTextField.large(hintText: 'La mia email', onChanged: (value) {}),
        CustomTextField.large(
            hintText: 'La mia password', onChanged: (value) {}),
        CustomTextField.large(
            hintText: 'Conferma password', onChanged: (value) {}),
      ],
    );
  }
}
