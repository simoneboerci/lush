import 'package:lush_app/core/commons/user/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  String? get currentUserId;

  Future<UserModel> loginAnonymously({required String username});

  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithGoogle();

  Future<void> logout();
}
