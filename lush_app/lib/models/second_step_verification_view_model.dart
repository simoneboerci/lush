import 'package:flutter/foundation.dart';

class SecondStepVerificationViewModel extends ChangeNotifier {
  String _address = '';
  String _nationality = '';
  String _email = '';
  String _phoneNumber = '';

  String get address => _address;
  String get nationality => _nationality;
  String get email => _email;
  String get phoneNumber => _phoneNumber;

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setNationality(String nationality) {
    _nationality = nationality;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }
}
