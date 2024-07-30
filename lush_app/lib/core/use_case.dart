import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
