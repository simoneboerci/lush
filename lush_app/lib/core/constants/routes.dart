import 'package:flutter/material.dart';
import 'package:lush_app/features/auth/presentation/pages/verification/first_step_verification_screen.dart';
import 'package:lush_app/pages/chats_screen.dart';
import 'package:lush_app/pages/direct_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/registration/fast_registration_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/login_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/verification/second_step_verification_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/verification/third_step_verification_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/verification/verification_completed_screen.dart';
import 'package:lush_app/features/auth/presentation/pages/registration/complete_registration_screen.dart';

const String cFastRegistrationScreen = '/fast_registration_screen';
const String cCompleteRegistrationScreen = '/complete_registration_screen';
const String cFirstStepVerificationScreen = '/first_step_verification_screen';
const String cSecondStepVerificationScreen = '/second_step_verification_screen';
const String cThirdStepVerificationScreen = '/third_step_verification_screen';
const String cVerificationCompletedScreen = '/verification_completed_screen';
const String cLoginScreen = '/login_screen';
const String cDirectScreen = '/direct_screen';
const String cChatsScreen = '/chats_screen';

final Map<String, WidgetBuilder> routes = {
  cFastRegistrationScreen: (context) => FastRegistrationScreen(),
  cCompleteRegistrationScreen: (context) => CompleteRegistrationScreen(),
  cFirstStepVerificationScreen: (context) => FirstStepVerificationScreen(),
  cSecondStepVerificationScreen: (context) => SecondStepVerificationScreen(),
  cThirdStepVerificationScreen: (context) => ThirdStepVerificationScreen(),
  cVerificationCompletedScreen: (context) =>
      const VerificationCompletedScreen(),
  cLoginScreen: (context) => LoginScreen(),
  cDirectScreen: (context) => const DirectScreen(),
  cChatsScreen: (context) => const ChatsScreen(),
};
