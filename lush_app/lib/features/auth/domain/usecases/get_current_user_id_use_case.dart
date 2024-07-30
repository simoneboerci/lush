import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/auth/domain/params/get_current_user_id_params.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserIdUseCase
    implements UseCase<String, GetCurrentUserIdParams> {
  final AuthRepository authRepository;

  const GetCurrentUserIdUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(GetCurrentUserIdParams params) async {
    return authRepository.getCurrentUserId();
  }
}
