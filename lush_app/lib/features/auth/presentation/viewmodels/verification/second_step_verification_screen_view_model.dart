import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';

class SecondStepVerificationScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController residenceAddressController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  dynamic residenceAddressItemClick(Prediction prediction) {
    residenceAddressController.text = prediction.description!;
    residenceAddressController.selection = TextSelection.fromPosition(
      TextPosition(offset: prediction.description!.length),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un\'email valida';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un numero di telefono valido';
    }
    return null;
  }

  void initializeTextFieldsWithCurrentUserData(User user) {
    residenceAddressController.text = user.personalInfo.residenceAddress ?? '';
    emailController.text = user.contactInfo.email ?? '';
    phoneNumberController.text = user.contactInfo.phoneNumber ?? '';
  }

  void getCurrentUser(BuildContext context, String userId) {
    context.read<UserBloc>().add(GetUserByIdEvent(userId));
  }

  void goToThirdStepVerificationScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cThirdStepVerificationScreen);
  }

  void onSecondStepCompletedButtonPressed(BuildContext context, String userId) {
    if (formKey.currentState!.validate()) {
      _storeUserData(context, userId);
    }
  }

  void _storeUserData(BuildContext context, String userId) {
    context.read<UserBloc>().add(
          ConfirmSecondStepVerificationEvent(
            userId: userId,
            residenceAddress: residenceAddressController.text,
            email: emailController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(),
          ),
        );
  }
}
