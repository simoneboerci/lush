import 'package:lush_app/features/collections/data/models/collection_card_model.dart';

abstract interface class CollectionRemoteDataSource {
  Future<List<CollectionCardModel>> getCollection();
  Future<CollectionCardModel> getCollectionCard(String id);
  Future<void> uploadCollectionCard(String filePath, String fileName);
}
