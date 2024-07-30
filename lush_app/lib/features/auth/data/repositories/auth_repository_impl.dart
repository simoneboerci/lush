import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/exceptions/auth_exceptions.dart';
import 'package:lush_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserRepository userRepository;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.userRepository,
  });

  @override
  User toEntity(UserModel model) => userRepository.toEntity(model);

  @override
  UserModel toModel(User entity) => userRepository.toModel(entity);

  @override
  Either<Failure, String> getCurrentUserId() {
    final currentUserId = authRemoteDataSource.currentUserId;
    if (currentUserId == null || currentUserId.isEmpty) {
      return left(const Failure(
          message: 'An error occurred while getting the current user id'));
    } else {
      return right(currentUserId);
    }
  }

  @override
  Future<Either<Failure, User>> loginAnonymously(
      {required String username}) async {
    return _getUser(() async =>
        await authRemoteDataSource.loginAnonymously(username: username));
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await authRemoteDataSource
        .registerWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await authRemoteDataSource
        .loginWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    return _getUser(() async => await authRemoteDataSource.loginWithGoogle());
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return right(await authRemoteDataSource.logout());
    } on AuthException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(
      Future<UserModel> Function() function) async {
    try {
      final userModel = await function();

      return right(toEntity(userModel));
    } on AuthException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
