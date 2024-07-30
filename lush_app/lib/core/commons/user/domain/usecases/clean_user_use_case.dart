import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/clean_user_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class CleanUserUseCase implements UseCase<User, CleanUserParams> {
  final UserRepository userRepository;

  const CleanUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(CleanUserParams params) async {
    return await userRepository.cleanUser(params.userId);
  }
}
