import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_events.dart';

class LoginScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreenViewModel();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un\'email valida';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci una password valida';
    }
    return null;
  }

  // On buttons pressed

  void onLoginButtonPressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      _loginWithEmailAndPassword(
        context,
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  void onLoginWithGoogleButtonPressed(BuildContext context) {
    _loginWithGoogle(context);
  }

  void onGoToFastRegistrationScreenButtonPressed(BuildContext context) {
    _goToFastRegistrationScreen(context);
  }

  void goToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cCollectionScreen);
  }

  // Internal logic

  void _loginWithEmailAndPassword(
      BuildContext context, String email, String password) {
    context.read<AuthBloc>().add(
        AuthLoginWithEmailAndPasswordEvent(email: email, password: password));
  }

  void _loginWithGoogle(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLoginWithGoogleEvent());
  }

  void _goToFastRegistrationScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cFastRegistrationScreen);
  }
}
