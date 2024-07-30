import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/domain/params/login_with_email_and_password_params.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmailAndPasswordUseCase
    implements UseCase<User, LoginWithEmailAndPasswordParams> {
  final AuthRepository authRepository;

  const LoginWithEmailAndPasswordUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(
      LoginWithEmailAndPasswordParams params) async {
    return await authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}
