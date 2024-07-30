import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/get_users_by_query_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class GetUsersByQueryUseCase
    implements UseCase<List<User>, GetUsersByQueryParams> {
  final UserRepository userRepository;

  const GetUsersByQueryUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<User>>> call(GetUsersByQueryParams params) async {
    return await userRepository.getUsersByQuery(params.parameter, params.query);
  }
}
