import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/user_model.dart';

import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_google_places_text_field.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';

class SecondStepVerificationScreen extends StatelessWidget {
  SecondStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _residenceAddressController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<UserModel?> _confirmSecondStepVerification(
      UserModel loggedUser) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserModel updatedUser = loggedUser.copyWith(
          personalInfo: loggedUser.personalInfo.copyWith(
            residenceAddress: _residenceAddressController.text,
          ),
          contactInfo: loggedUser.contactInfo.copyWith(
            email: _emailController.text,
            phoneNumber: _phoneNumberController.text,
          ),
        );

        await FirebaseHelper().userHelper.storeUserData(updatedUser);

        return updatedUser;
      } catch (e) {
        print('Errore durante la validazione del secondo step di verifica: $e');
      }
    }

    return null;
  }

  void _onPressed(BuildContext context) {
    _confirmSecondStepVerification(
            Provider.of<UserProvider>(context, listen: false).user!)
        .then((user) {
      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(
            context, '/third_step_verification_screen');
      }
    });
  }

  void _updateTextFieldTextsBasedOnUser(BuildContext context) {
    UserModel? currentUser =
        Provider.of<UserProvider>(context, listen: false).user;

    if (currentUser != null) {
      _residenceAddressController.text =
          currentUser.personalInfo.residenceAddress ?? '';
      _emailController.text = currentUser.contactInfo.email ?? '';
      _phoneNumberController.text = currentUser.contactInfo.phoneNumber ?? '';
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
                  CustomGooglePlacesTextField(
                    controller: _residenceAddressController,
                    itemClick: (prediction) {
                      _residenceAddressController.text =
                          prediction.description!;
                      _residenceAddressController.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length),
                      );
                    },
                    hintText: 'Il mio indirizzo di residenza',
                  ),
                  CustomTextField.large(
                    controller: _emailController,
                    hintText: 'La mia email',
                  ),
                  CustomTextField.large(
                    controller: _phoneNumberController,
                    hintText: 'Il mio numero di telefono',
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
