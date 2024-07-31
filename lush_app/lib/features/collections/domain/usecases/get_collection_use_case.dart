import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';
import 'package:lush_app/features/collections/domain/params/get_collection_params.dart';
import 'package:lush_app/features/collections/domain/repositories/collection_repository.dart';

class GetCollectionUseCase
    implements UseCase<List<CollectionCard>, GetCollectionParams> {
  final CollectionRepository collectionRepository;

  const GetCollectionUseCase(this.collectionRepository);

  @override
  Future<Either<Failure, List<CollectionCard>>> call(
      GetCollectionParams params) async {
    return await collectionRepository.getCollection();
  }
}
