import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/first_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class ConfirmFirstStepVerificationUseCase
    implements UseCase<User, FirstStepVerificationParams> {
  final UserRepository userRepository;

  const ConfirmFirstStepVerificationUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(FirstStepVerificationParams params) async {
    return await userRepository.confirmFirstStepVerification(
      userId: params.userId,
      name: params.name,
      surname: params.surname,
      birthDate: params.birthDate,
      birthAddress: params.birthAddress,
    );
  }
}
