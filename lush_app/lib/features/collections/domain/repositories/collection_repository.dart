import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/collections/data/models/collection_card_model.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';

abstract interface class CollectionRepository
    implements Repository<CollectionCard, CollectionCardModel> {
  Future<Either<Failure, List<CollectionCard>>> getCollection();
  Future<Either<Failure, CollectionCard>> getCollectionCardDetails(String id);
}
