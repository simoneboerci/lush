import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/params/second_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';

class ConfirmSecondStepVerificationUseCase
    implements UseCase<User, SecondStepVerificationParams> {
  final UserRepository userRepository;

  const ConfirmSecondStepVerificationUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(
      SecondStepVerificationParams params) async {
    return await userRepository.confirmSecondStepVerification(
      userId: params.userId,
      residenceAddress: params.residenceAddress,
      email: params.email,
      phoneNumber: params.phoneNumber,
    );
  }
}
