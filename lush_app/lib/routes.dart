import 'package:flutter/material.dart';

import 'package:lush_app/screens/fast_registration_screen.dart';
import 'package:lush_app/screens/first_step_verification_screen.dart';
import 'package:lush_app/screens/login_screen.dart';
import 'package:lush_app/screens/second_step_verification_screen.dart';
import 'package:lush_app/screens/third_step_verification_screen.dart';
import 'package:lush_app/screens/verification_completed_screen.dart';
import 'screens/complete_registration_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => FirstStepVerificationScreen(),
  '/fast_registration_screen': (context) => FastRegistrationScreen(),
  '/complete_registration_screen': (context) => RegistrationScreen(),
  '/first_step_verification_screen': (context) => FirstStepVerificationScreen(),
  '/second_step_verification_screen': (context) =>
      SecondStepVerificationScreen(),
  '/third_step_verification_screen': (context) => ThirdStepVerificationScreen(),
  '/verification_completed_screen': (context) =>
      const VerificationCompletedScreen(),
  '/login_screen': (context) => LoginScreen(),
};
