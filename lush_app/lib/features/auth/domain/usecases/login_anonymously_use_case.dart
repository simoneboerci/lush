import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/features/auth/domain/params/login_anonymously_params.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';

class LoginAnonymouslyUseCase implements UseCase<User, LoginAnonymouslyParams> {
  final AuthRepository authRepository;

  const LoginAnonymouslyUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginAnonymouslyParams params) async {
    return await authRepository.loginAnonymously(username: params.username);
  }
}
