import 'package:flutter/material.dart';

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
                  fontSize: ,
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
        _buildFormField(label: 'Il mio nome', onChanged: (value) {}),
        _buildFormField(label: 'Il mio username', onChanged: (value) {}),
        _buildFormField(label: 'La mia email', onChanged: (value) {}),
        _buildFormField(label: 'La mia password', onChanged: (value) {}),
        _buildFormField(label: 'Conferma password', onChanged: (value) {}),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    bool obscureText = false,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: kAccentColor,
        cursorHeight: 16,
        style: const TextStyle(
          height: 2,
          color: Colors.white,
        ),
        cursorErrorColor: kSecondaryColor,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white30,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          focusColor: kAccentColor,
          fillColor: const Color(0xFF333333),
          hintText: label,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
