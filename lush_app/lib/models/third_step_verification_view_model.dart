import 'package:flutter/foundation.dart';

class ThirdStepVerificationViewModel extends ChangeNotifier {
  String _cf = '';

  String get cf => _cf;

  void setCF(String cf) {
    _cf = cf;
    notifyListeners();
  }
}
