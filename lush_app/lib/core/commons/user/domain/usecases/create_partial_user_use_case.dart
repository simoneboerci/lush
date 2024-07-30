import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/create_partial_user_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class CreatePartialUserUseCase
    implements UseCase<User, CreatePartialUserParams> {
  final UserRepository userRepository;

  const CreatePartialUserUseCase(this.userRepository);
  @override
  Future<Either<Failure, User>> call(CreatePartialUserParams params) async {
    return await userRepository.createPartialUser(params.username);
  }
}
