import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';
import 'package:lush_app/models/lush_user.dart';
import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_google_places_text_field.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/registration_header.dart';
import 'package:provider/provider.dart';

class SecondStepVerificationScreen extends StatelessWidget {
  SecondStepVerificationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _residenceAddressController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<LushUser?> _confirmSecondStepVerification(LushUser loggedUser) async {
    if (_formKey.currentState!.validate()) {
      try {
        LushUser updatedUser = LushUser.copyWith(
          user: loggedUser,
          residenceAddress: _residenceAddressController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
        );

        await FirebaseHelper.storeUserData(updatedUser);

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
