import 'package:flutter/foundation.dart';

import '../models/lush_user.dart';

class UserProvider with ChangeNotifier {
  LushUser? _user;

  LushUser? get user => _user;

  void setUser(LushUser user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
