import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lush_app/widgets/custom_date_text_field.dart';
import 'package:lush_app/widgets/custom_google_places_text_field.dart';
import 'package:provider/provider.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/lush_user.dart';

import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';

class FirstStepVerificationScreen extends StatelessWidget {
  FirstStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthAddressController = TextEditingController();

  Future<LushUser?> _confirmFirstStepVerification(LushUser loggedUser) async {
    if (_formKey.currentState!.validate()) {
      try {
        LushUser updatedUser = LushUser.copyWith(
          user: loggedUser,
          name: _nameController.text,
          surname: _surnameController.text,
          birthDate: DateFormat('dd/MM/yyyy').parse(_birthDateController.text),
          birthAddress: _birthAddressController.text,
        );

        await FirebaseHelper.storeUserData(updatedUser);

        return updatedUser;
      } catch (e) {
        print('Errore durante il primo step di verifica: $e');
      }
    }

    return null;
  }

  void _onPressed(BuildContext context) {
    _confirmFirstStepVerification(
            Provider.of<UserProvider>(context, listen: false).user!)
        .then((user) {
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(
            context, '/second_step_verification_screen');
      }
    });
  }

  void _updateTextFieldTextsBasedOnUser(BuildContext context) {
    LushUser? currentUser =
        Provider.of<UserProvider>(context, listen: false).user;

    if (currentUser != null) {
      _nameController.text = currentUser.name ?? '';
      _surnameController.text = currentUser.surname ?? '';
      _birthDateController.text =
          DateFormat('dd/MM/yyyy').format(currentUser.birthDate!);
      _birthAddressController.text = currentUser.birthAddress ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTextFieldTextsBasedOnUser(context);

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
            textFields: [
              CustomTextField.large(
                hintText: 'Il mio nome',
                controller: _nameController,
              ),
              CustomTextField.large(
                hintText: 'Il mio cognome',
                controller: _surnameController,
              ),
              CustomDateTextField(
                hintText: 'La mia data di nascita',
                controller: _birthDateController,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
              ),
              CustomGooglePlacesTextField(
                controller: _birthAddressController,
                itemClick: (prediction) {
                  _birthAddressController.text = prediction.description!;
                  _birthAddressController.selection =
                      TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length),
                  );
                },
                hintText: 'Il mio indirizzo di nascita',
              ),
            ],
            button: CustomElevatedButton.variant(
              padding: const EdgeInsets.only(top: 16.0),
              text: 'Procedi',
              onPressed: () => _onPressed(context),
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
