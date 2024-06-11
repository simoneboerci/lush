import 'package:flutter/foundation.dart';

class FirstStepVerificationViewModel extends ChangeNotifier {
  String _name = '';
  String _surname = '';
  DateTime _birthDate = DateTime.now();
  String _birthLocation = '';

  String get name => _name;
  String get surname => _surname;
  DateTime get birthDate => _birthDate;
  String get birthLocation => _birthLocation;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setSurname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  void setBirthDate(DateTime birthDate) {
    _birthDate = birthDate;
    notifyListeners();
  }

  void setBirthLocation(String birthLocation) {
    _birthLocation = birthLocation;
    notifyListeners();
  }
}
