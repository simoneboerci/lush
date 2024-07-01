import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';
import 'package:lush_app/models/lush_user.dart';
import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';
import 'package:provider/provider.dart';

class ThirdStepVerificationScreen extends StatelessWidget {
  ThirdStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fiscalCodeController = TextEditingController();

  bool _validateFiscalCode(String code) {
    String formattedCode = code.toUpperCase();
    if (formattedCode.length != 16) {
      return false;
    }
    final validChars = RegExp(r'^[A-Z0-9]+$');
    if (!validChars.hasMatch(formattedCode)) {
      return false;
    }

    final oddValues = {
      '0': 1,
      '1': 0,
      '2': 5,
      '3': 7,
      '4': 9,
      '5': 13,
      '6': 15,
      '7': 17,
      '8': 19,
      '9': 21,
      'A': 1,
      'B': 0,
      'C': 5,
      'D': 7,
      'E': 9,
      'F': 13,
      'G': 15,
      'H': 17,
      'I': 19,
      'J': 21,
      'K': 2,
      'L': 4,
      'M': 18,
      'N': 20,
      'O': 11,
      'P': 3,
      'Q': 6,
      'R': 8,
      'S': 12,
      'T': 14,
      'U': 16,
      'V': 10,
      'W': 22,
      'X': 25,
      'Y': 24,
      'Z': 23
    };

    final evenValues = {
      '0': 0,
      '1': 1,
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9,
      'A': 0,
      'B': 1,
      'C': 2,
      'D': 3,
      'E': 4,
      'F': 5,
      'G': 6,
      'H': 7,
      'I': 8,
      'J': 9,
      'K': 10,
      'L': 11,
      'M': 12,
      'N': 13,
      'O': 14,
      'P': 15,
      'Q': 16,
      'R': 17,
      'S': 18,
      'T': 19,
      'U': 20,
      'V': 21,
      'W': 22,
      'X': 23,
      'Y': 24,
      'Z': 25
    };

    const controlCharMap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    int sum = 0;
    for (int i = 0; i < 15; i++) {
      final char = formattedCode[i];
      if (i % 2 == 0) {
        sum += oddValues[char]!;
      } else {
        sum += evenValues[char]!;
      }
    }

    final expectedCheckChar = controlCharMap[sum % 26];
    return expectedCheckChar == formattedCode[15];
  }

  Future<LushUser?> _confirmThirdStepVerification(LushUser loggedUser) async {
    if (_formKey.currentState!.validate()) {
      try {
        LushUser updatedUser = LushUser.copyWith(
          user: loggedUser,
          fiscalCode: _fiscalCodeController.text.toUpperCase(),
        );

        await FirebaseHelper.storeUserData(updatedUser);

        return updatedUser;
      } catch (e) {
        print('Errore durante la validazione del terzo step di verifica: $e');
      }
    }

    return null;
  }

  void _onPressed(BuildContext context) {
    _confirmThirdStepVerification(
            Provider.of<UserProvider>(context, listen: false).user!)
        .then((user) {
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(
            context, '/verification_completed_screen');
      }
    });
  }

  void _updateTextFieldTextsBasedOnUser(BuildContext context) {
    LushUser? currentUser =
        Provider.of<UserProvider>(context, listen: false).user;

    if (currentUser != null) {
      _fiscalCodeController.text = currentUser.fiscalCode ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTextFieldTextsBasedOnUser(context);
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
                textFields: [
                  CustomTextField.large(
                    hintText: 'Il mio codice fiscale',
                    controller: _fiscalCodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Per favore, inserisci il tuo codice fiscale';
                      } else if (!_validateFiscalCode(value)) {
                        return 'Per favore, inserisci un codice fiscale valido';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
                button: CustomElevatedButton.variant(
                  padding: const EdgeInsets.only(top: 16.0),
                  text: 'Richiedi Verifica',
                  onPressed: () => _onPressed(context),
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
