import 'package:flutter/material.dart';

import 'package:lush_app/screens/fast_registration_screen.dart';
import 'screens/complete_registration_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => FastRegistrationScreen(),
  '/fast_registration': (context) => FastRegistrationScreen(),
  '/complete_registration': (context) => RegistrationScreen(),
};
