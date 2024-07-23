import 'package:flutter/material.dart';

import 'package:lush_app/screens/chats_screen.dart';
import 'package:lush_app/screens/direct_screen.dart';
import 'package:lush_app/screens/fast_registration_screen.dart';
import 'package:lush_app/screens/first_step_verification_screen.dart';
import 'package:lush_app/screens/login_screen.dart';
import 'package:lush_app/screens/second_step_verification_screen.dart';
import 'package:lush_app/screens/shop_screen.dart';
import 'package:lush_app/screens/third_step_verification_screen.dart';
import 'package:lush_app/screens/verification_completed_screen.dart';
import 'package:lush_app/screens/complete_registration_screen.dart';

const String cFastRegistrationScreen = '/fast_registration_screen';
const String cCompleteRegistrationScreen = '/complete_registration_screen';
const String cFirstStepVerificationScreen = '/first_step_verification_screen';
const String cSecondStepVerificationScreen = '/second_step_verification_screen';
const String cThirdStepVerificationScreen = '/third_step_verification_screen';
const String cVerificationCompletedScreen = '/verification_completed_screen';
const String cLoginScreen = '/login_screen';
const String cShopScreen = '/shop_screen';
const String cDirectScreen = '/direct_screen';
const String cChatsScreen = '/chats_screen';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => LoginScreen(),
  cFastRegistrationScreen: (context) => FastRegistrationScreen(),
  cCompleteRegistrationScreen: (context) => RegistrationScreen(),
  cFirstStepVerificationScreen: (context) => FirstStepVerificationScreen(),
  cSecondStepVerificationScreen: (context) => SecondStepVerificationScreen(),
  cThirdStepVerificationScreen: (context) => ThirdStepVerificationScreen(),
  cVerificationCompletedScreen: (context) =>
      const VerificationCompletedScreen(),
  cLoginScreen: (context) => LoginScreen(),
  cShopScreen: (context) => const ShopScreen(),
  cDirectScreen: (context) => const DirectScreen(),
  cChatsScreen: (context) => const ChatsScreen(),
};
