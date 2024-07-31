import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/features/collections/data/datasources/collection_remote_data_source.dart';
import 'package:lush_app/features/collections/data/models/collection_card_model.dart';

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionRemoteDataSourceImpl(
      {FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<List<CollectionCardModel>> getCollection() async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseCollectionsLabels.collectionCards)
          .get();

      return querySnapshot.docs
          .map((doc) => CollectionCardModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch images: $e');
    }
  }

  @override
  Future<CollectionCardModel> getCollectionCard(String id) async {
    try {
      final docSnapshot = await _firestore
          .collection(FirebaseCollectionsLabels.collectionCards)
          .doc(id)
          .get();
      if (docSnapshot.exists) {
        return CollectionCardModel.fromMap(docSnapshot.data()!);
      } else {
        throw Exception('Collection card not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch image details: $e');
    }
  }

  @override
  Future<void> uploadCollectionCard(String filePath, String fileName) async {
    try {
      final ref = _storage.ref('images/$fileName');
      await ref.putFile(File(filePath));

      final downloadUrl = await ref.getDownloadURL();

      await _firestore
          .collection(FirebaseCollectionsLabels.collectionCards)
          .add(
        {
          CollectionCardModelField.id.name: fileName,
          CollectionCardModelField.imageUrl.name: downloadUrl,
        },
      );
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
