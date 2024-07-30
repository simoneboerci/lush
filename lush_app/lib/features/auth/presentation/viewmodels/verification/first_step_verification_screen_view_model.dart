import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_events.dart';

class FirstStepVerificationScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthAddressController = TextEditingController();

  dynamic birthAddressItemClick(Prediction prediction) {
    birthAddressController.text = prediction.description!;
    birthAddressController.selection = TextSelection.fromPosition(
      TextPosition(offset: prediction.description!.length),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un nome valido';
    }
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un cognome valido';
    }
    return null;
  }

  void getCurrentUserId(BuildContext context) {
    context.read<AuthBloc>().add(const AuthGetCurrentUserIdEvent());
  }

  void getCurrentUser(BuildContext context, String userId) {
    context.read<UserBloc>().add(GetUserByIdEvent(userId));
  }

  void initializeTextFieldsWithCurrentUserData(User user) {
    String? birthDate = user.personalInfo.birthDate.toString();
    if (birthDate == 'null') birthDate = null;

    nameController.text = user.personalInfo.name ?? '';
    surnameController.text = user.personalInfo.surname ?? '';
    birthDateController.text = birthDate ?? '';
    birthAddressController.text = user.personalInfo.birthAddress ?? '';
  }

  void onFirstStepCompletedButtonPressed(
      BuildContext context, String currentUserId) {
    if (formKey.currentState!.validate()) {
      _storeUserData(context, currentUserId);
    }
  }

  void _storeUserData(BuildContext context, String userId) {
    String birthDateString = birthDateController.text.trim();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    DateTime birthDate = dateFormat.parse(birthDateString);

    context.read<UserBloc>().add(
          ConfirmFirstStepVerificationEvent(
            userId: userId,
            name: nameController.text,
            surname: surnameController.text,
            birthDate: birthDate,
            birthAddress: birthAddressController.text,
          ),
        );
  }

  void goToSecondStepVerificationScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cSecondStepVerificationScreen);
  }
}
