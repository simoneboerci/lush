import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/complete_user_creation_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class CompleteUserCreationUseCase
    implements UseCase<User, CompleteUserCreationParams> {
  final UserRepository userRepository;

  const CompleteUserCreationUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(CompleteUserCreationParams params) async {
    return await userRepository.completeUserCreation(params.user);
  }
}
