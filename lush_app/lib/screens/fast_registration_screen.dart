import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/routes.dart';
import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/services/user_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/user_model.dart';

import 'package:lush_app/widgets/registration_header.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/custom_text.dart';

class FastRegistrationController {
  final TextEditingController usernameController = TextEditingController();

  Future<UserModel?> registerAnonymously() async {
    UserModel? loggedUser = await FirebaseHelper()
        .loginHelper
        .loginAnonymously(usernameController.text);

    return loggedUser;
  }

  Future<UserModel?> registerWithGoogle() async {
    UserModel? loggedUser =
        await FirebaseHelper().loginHelper.loginWithGoogle();

    if (loggedUser != null) {
      return await FirebaseHelper().userHelper.getUserWithUid(loggedUser.id);
    }
    return null;
  }
}

class FastRegistrationScreen extends StatelessWidget {
  FastRegistrationScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FastRegistrationController _controller = FastRegistrationController();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 25.0,
          ),
          _buildRegistrationForm(context),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RegistrationHeader(
          text: 'Registratione veloce',
        ),
        CustomForm(
          formKey: _formKey,
          textFields: [
            CustomTextField.large(
              hintText: 'Il mio username',
              controller: _controller.usernameController,
              validator: _validateUsername,
            ),
          ],
          button: CustomElevatedButton(
            padding: const EdgeInsets.only(top: 16.0),
            text: 'Conferma',
            onPressed: () => _onConfirmPressed(context),
          ),
        ),
        _buildOrDivider(),
        CustomElevatedButton.google(
          text: 'Registrati con Google',
          onPressed: () => _onGoogleButtonPressed(context),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return const Padding(
      padding: EdgeInsets.all(
        16.0,
      ),
      child: CustomText(
        text: 'Oppure',
        color: Colors.white,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushReplacementNamed(context, cLoginScreen),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        foregroundColor: cPrimaryColor,
      ),
      child: const CustomText(
        text: 'Accedi',
        fontSize: 18.0,
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Per favore, inserisci un username';
    }
    return null;
  }

  void _onConfirmPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _controller.registerAnonymously().then((user) {
        if (user != null) _completeRegistration(context, user);
      });
    }
  }

  void _onGoogleButtonPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _controller.registerWithGoogle().then((user) {
        if (user != null) _completeRegistration(context, user);
      });
    }
  }

  void _completeRegistration(BuildContext context, UserModel user) {
    Navigator.pushNamed(context, cCompleteRegistrationScreen);
    Provider.of<UserProvider>(context, listen: false).setUser(user);
  }
}
