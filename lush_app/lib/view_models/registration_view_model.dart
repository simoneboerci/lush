import 'package:flutter/foundation.dart';

class RegistrationViewModel extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';

  String get username => _username;
  String get email => _email;
  String get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void registerUser() {
    print('Registrazione con: $_username, $_email, $_password');
  }
}
