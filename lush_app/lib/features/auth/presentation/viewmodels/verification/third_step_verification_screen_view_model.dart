import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';

class ThirdStepVerificationScreenViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fiscalCodeController = TextEditingController();

  String? validateFiscalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un codice fiscale valido';
    }
    String formattedCode = value.toUpperCase();
    if (formattedCode.length != 16) {
      return 'Inserisci un codice fiscale valido';
    }
    final validChars = RegExp(r'^[A-Z0-9]+$');
    if (!validChars.hasMatch(formattedCode)) {
      return 'Inserisci un codice fiscale valido';
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

    if (expectedCheckChar == formattedCode[15]) {
      return null;
    }

    return 'Inserisci un codice fiscale valido';
  }

  void initializeTextFieldsWithCurrentUserData(User user) {
    fiscalCodeController.text = user.personalInfo.fiscalCode ?? '';
  }

  void getCurrentUser(BuildContext context, String userId) {
    context.read<UserBloc>().add(GetUserByIdEvent(userId));
  }

  void goToVerificationCompletedScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cVerificationCompletedScreen);
  }

  void onThirdStepCompletedButtonOnPressed(
      BuildContext context, String userId) {
    if (formKey.currentState!.validate()) {
      _storeUserData(context, userId);
    }
  }

  void _storeUserData(BuildContext context, String userId) {
    context.read<UserBloc>().add(
          ConfirmThirdStepVerificationEvent(
            userId: userId,
            fiscalCode: fiscalCodeController.text.trim(),
          ),
        );
  }
}
