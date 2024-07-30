import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/third_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class ConfirmThirdStepVerificationUseCase
    implements UseCase<User, ThirdStepVerificationParams> {
  final UserRepository userRepository;

  const ConfirmThirdStepVerificationUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(ThirdStepVerificationParams params) async {
    return await userRepository.confirmThirdStepVerification(
      userId: params.userId,
      fiscalCode: params.fiscalCode,
    );
  }
}
