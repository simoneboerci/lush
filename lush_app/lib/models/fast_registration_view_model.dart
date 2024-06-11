import 'package:flutter/material.dart';

class FastRegistrationViewModel extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void registerUser() {
    print('Registrazione veloce con: $_username');
  }
}
