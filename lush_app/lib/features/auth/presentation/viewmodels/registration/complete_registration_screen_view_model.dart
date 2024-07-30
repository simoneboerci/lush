import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_events.dart';

class CompleteRegistrationScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passowordConfirmationController =
      TextEditingController();

  CompleteRegistrationScreenViewModel();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un nome valido';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un username valido';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un\'email valida';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci una password valida';
    } else if (value != passowordConfirmationController.text) {
      return 'Le password non corrispondono';
    }
    return null;
  }

  String? validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Conferma la password';
    } else if (value != passwordController.text) {
      return 'Le password non corrispondono';
    }
    return null;
  }

  void initializeTextFieldsWithCurrentUserData(User user) {
    nameController.text = user.personalInfo.name ?? '';
    usernameController.text = user.chatInfo.username ?? '';
    emailController.text = user.contactInfo.email ?? '';
    passwordController.text = user.contactInfo.password ?? '';
  }

  void onCompleteRegistrationButtonPressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      _registerWithEmailAndPassword(context);
    }
  }

  void _registerWithEmailAndPassword(BuildContext context) {
    context.read<AuthBloc>().add(AuthRegisterWithEmailAndPasswordEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim()));
  }

  void createUserOnTheDatabase(BuildContext context, User user) {
    final updatedUser = user.copyWith(
      personalInfo: user.personalInfo.copyWith(
        name: nameController.text,
      ),
      chatInfo: user.chatInfo.copyWith(
        username: usernameController.text.trim(),
      ),
      contactInfo: user.contactInfo.copyWith(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    context.read<UserBloc>().add(CompleteUserCreationEvent(updatedUser));
  }

  void goToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cFirstStepVerificationScreen);
  }
}
