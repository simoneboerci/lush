import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/update_user_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class UpdateUserUseCase implements UseCase<User, UpdateUserParams> {
  final UserRepository userRepository;

  const UpdateUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await userRepository.updateUser(params.user);
  }
}
