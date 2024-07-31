import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/collections/data/datasources/collection_remote_data_source.dart';
import 'package:lush_app/features/collections/data/models/collection_card_model.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';
import 'package:lush_app/features/collections/domain/repositories/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDataSource collectionRemoteDataSource;

  const CollectionRepositoryImpl(this.collectionRemoteDataSource);

  @override
  CollectionCard toEntity(CollectionCardModel model) {
    return CollectionCard(
      id: model.id,
      title: model.title,
      subtitle: model.subtitle,
      imageUrl: model.imageUrl,
      hashtags: model.hashtags,
    );
  }

  @override
  CollectionCardModel toModel(CollectionCard entity) {
    return CollectionCardModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      imageUrl: entity.imageUrl,
      hashtags: entity.hashtags,
    );
  }

  @override
  Future<Either<Failure, List<CollectionCard>>> getCollection() async {
    try {
      final imageModels = await collectionRemoteDataSource.getCollection();
      final images = imageModels.map((model) => toEntity(model)).toList();
      return right(images);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CollectionCard>> getCollectionCardDetails(
      String id) async {
    try {
      final imageModel = await collectionRemoteDataSource.getCollectionCard(id);
      return right(toEntity(imageModel));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
