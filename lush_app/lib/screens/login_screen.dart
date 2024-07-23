import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/constants/routes.dart';

import 'package:lush_app/models/user_model.dart';

import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/registration_header.dart';
import 'package:lush_app/widgets/custom_form.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/custom_text.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<UserModel?> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    UserModel? loggedUser = await FirebaseHelper()
        .loginHelper
        .loginWithEmailAndPassword(email, password);

    if (loggedUser != null) {
      return FirebaseHelper().userHelper.getUserWithUid(loggedUser.id);
    }

    return null;
  }

  Future<UserModel?> loginWithGoogle() async {
    UserModel? loggedUser =
        await FirebaseHelper().loginHelper.loginWithGoogle();

    if (loggedUser != null) {
      return await FirebaseHelper().userHelper.getUserWithUid(loggedUser.id);
    }

    return null;
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _controller = LoginController();

  void _completeLogin(BuildContext context, UserModel user) {
    Provider.of<UserProvider>(context, listen: false).setUser(user);
    Navigator.pushReplacementNamed(context, cChatsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 25.0),
          _buildLoginForm(context),
          _buildRegisterButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RegistrationHeader(
          text: 'Accedi al tuo account',
        ),
        CustomForm(
          formKey: _formKey,
          textFields: [
            CustomTextField.large(
              hintText: 'La mia email',
              controller: _controller.emailController,
              validator: _validateEmail,
            ),
            CustomTextField.large(
              hintText: 'La mia password',
              controller: _controller.passwordController,
              validator: _validatePassword,
              obscureText: true,
            ),
          ],
          button: CustomElevatedButton(
            padding: const EdgeInsets.only(top: 16.0),
            text: 'Entra',
            onPressed: () => _onLoginPressed(context),
          ),
        ),
        const _OrDivider(),
        CustomElevatedButton.google(
          text: 'Accedi con Google',
          onPressed: () => _onGoogleLoginPressed(context),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.pushReplacementNamed(context, cFastRegistrationScreen),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        foregroundColor: cPrimaryColor,
      ),
      child: const CustomText(
        text: 'Registrati',
        fontSize: 18.0,
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Per favore, inserisci un email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Per favore, inserisci una password';
    }
    return null;
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _controller.login().then((user) {
        if (user != null) _completeLogin(context, user);
      });
    }
  }

  void _onGoogleLoginPressed(BuildContext context) {
    _controller.loginWithGoogle().then((user) {
      if (user != null) _completeLogin(context, user);
    });
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomText(
        text: 'Oppure',
        color: Colors.white,
      ),
    );
  }
}
