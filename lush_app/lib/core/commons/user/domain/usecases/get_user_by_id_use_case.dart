import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/get_user_by_id_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class GetUserByIdUseCase implements UseCase<User, GetUserByIdParams> {
  final UserRepository userRepository;

  GetUserByIdUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(GetUserByIdParams params) async {
    return await userRepository.getUserById(params.userId);
  }
}
