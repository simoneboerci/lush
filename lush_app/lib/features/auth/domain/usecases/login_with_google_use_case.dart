import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/domain/params/login_with_google_params.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithGoogleUseCase implements UseCase<User, LoginWithGoogleParams> {
  final AuthRepository authRepository;

  const LoginWithGoogleUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginWithGoogleParams params) async {
    return await authRepository.loginWithGoogle();
  }
}
