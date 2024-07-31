import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';
import 'package:lush_app/features/collections/domain/params/get_collection_card_params.dart';
import 'package:lush_app/features/collections/domain/repositories/collection_repository.dart';

class GetCollectionCardUseCase
    implements UseCase<CollectionCard, GetCollectionCardParams> {
  final CollectionRepository collectionRepository;

  const GetCollectionCardUseCase(this.collectionRepository);

  @override
  Future<Either<Failure, CollectionCard>> call(
      GetCollectionCardParams params) async {
    return await collectionRepository.getCollectionCardDetails(params.id);
  }
}
