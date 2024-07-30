import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/delete_user_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class DeleteUserUseCase implements UseCase<User, DeleteUserParams> {
  final UserRepository userRepository;

  const DeleteUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.userId);
  }
}
