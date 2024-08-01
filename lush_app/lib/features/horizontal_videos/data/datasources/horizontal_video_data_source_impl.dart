import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/core/exceptions/horizontal_video_exceptions.dart';
import 'package:lush_app/features/horizontal_videos/data/datasources/horizontal_video_data_source.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';

class HorizontalVideoDataSourceImpl implements HorizontalVideoDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  HorizontalVideoDataSourceImpl(
      {FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<List<HorizontalVideoModel>> getHorizontalVideos() async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .get();

      return querySnapshot.docs
          .map((doc) => HorizontalVideoModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw GetHorizontalVideosException(
          'An error occurred while getting horizontal videos from the database: $e');
    }
  }

  @override
  Future<HorizontalVideoModel> getHorizontalVideoById(String id) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .doc(id)
          .get();

      if (!querySnapshot.exists || querySnapshot.data() == null) {
        throw HorizontalVideoNotFoundException(
            'Unable to find horizontal video with id: $id');
      }

      return HorizontalVideoModel.fromMap(querySnapshot.data()!);
    } catch (e) {
      throw GetHorizontalVideoException(
          'An error occurred while getting horizontal video with id $id: $e');
    }
  }

  @override
  Future<String> uploadHorizontalVideoThumbnail(
    String filePath,
    String fileName,
  ) async {
    try {
      /*final downloadUrl = await _uploadFileAndGetDownloadUrl(
          'horizontalVideos', filePath, fileName);*/

      //TODO: Implementare sistema di caricamento della thumbnail
      return '';
    } catch (e) {
      throw UploadHorizontalVideoThumbnailException(
          'An error occurred while uploading horizontal video thumbnail: $e');
    }
  }

  @override
  Future<HorizontalVideoModel> uploadHorizontalVideo(
    String filePath,
    String fileName,
    String thumbnailUrl,
  ) async {
    try {
      final downloadUrl = await _uploadFileAndGetDownloadUrl(
          'horizontalVideos', filePath, fileName);

      final horizontalVideoModel = HorizontalVideoModel(
        id: fileName,
        url: downloadUrl,
        thumbnailUrl: thumbnailUrl,
      );

      await _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .add(horizontalVideoModel.toMap());

      return horizontalVideoModel;
    } catch (e) {
      throw UploadHorizontalVideoException(
          'An error occurred while uploading horizontal video: $e');
    }
  }

  Future<String> _uploadFileAndGetDownloadUrl(
    String storageLocationPath,
    String filePath,
    String fileName,
  ) async {
    final ref = _storage.ref('$storageLocationPath/$fileName');
    await ref.putFile(File(filePath));
    return await ref.getDownloadURL();
  }
}
