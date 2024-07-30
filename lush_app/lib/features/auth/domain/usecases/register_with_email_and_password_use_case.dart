import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/domain/params/register_with_email_and_password_params.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmailAndPasswordUseCase
    implements UseCase<User, RegisterWithEmailAndPasswordParams> {
  final AuthRepository authRepository;

  const RegisterWithEmailAndPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(
      RegisterWithEmailAndPasswordParams params) async {
    return await authRepository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
