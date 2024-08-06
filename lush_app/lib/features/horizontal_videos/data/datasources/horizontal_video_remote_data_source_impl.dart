import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lush_app/features/horizontal_videos/data/datasources/horizontal_video_remote_data_source.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_advanced_stats_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_details_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_file_info_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_metadata_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/core/exceptions/horizontal_video_exceptions.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_state_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_info_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_interactions_model.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class HorizontalVideoRemoteDataSourceImpl
    implements HorizontalVideoRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  HorizontalVideoRemoteDataSourceImpl(
      {FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<List<HorizontalVideoModel>> getAllVideos() async {
    try {
      // Otttieni lo snapshot dei video dal database
      final videosSnapshot = await _getVideoCollectionSnapshot();

      // Ritorna la lista di modelli video
      return _getModelsFromSnapshot(videosSnapshot);
    } catch (e) {
      throw GetAllHorizontalVideosRemoteException(
          'An error occurred while getting all videos from the database: $e');
    }
  }

  @override
  Future<List<HorizontalVideoModel>> fetchVideos(
      {String? lastDocumentId, int pageSize = 20}) async {
    try {
      // Ottieni una query del database limitando il numero di oggetti a quanto definito
      var query = _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .limit(pageSize);

      // Verifica se l'id dell'ultimo documento recuperato
      if (lastDocumentId != null) {
        // Ottieni l'ultimo documento recuperato
        final lastDocument = await _getVideoDocumentSnapshot(lastDocumentId);

        // Modifica la query facendo partire il conteggio dei documenti recuperati da dopo l'ultimo documento recuperato
        query = query.startAfterDocument(lastDocument);
      }

      // Ottieni lo snapshot a partire dalla query
      final videoSnapshot = await query.get();

      // Assicurati che lo snapshot contenga dei documenti
      if (videoSnapshot.docs.isEmpty) {
        throw const HorizontalVideoNotFoundRemoteException(
            'The horizontal video collection is empty');
      }

      // Ottieni una lista di modelli a partire dallo snapshot
      final videoModels = _getModelsFromSnapshot(videoSnapshot);

      // Ritorna la lista di modelli
      return videoModels;
    } catch (e) {
      throw FetchHorizontalVideosRemoteException(
          'An error occurred while fetching videos from the database: $e');
    }
  }

  @override
  Future<HorizontalVideoModel> getVideoById(String id) async {
    try {
      // Ottieni lo snapshot del documento in base all'id
      final videoSnapshot = await _getVideoDocumentSnapshot(id);

      // Assicurati che lo snapshot esista e che contenga dati
      if (!videoSnapshot.exists || videoSnapshot.data() == null) {
        throw HorizontalVideoNotFoundRemoteException(
            'Unable to find horizontal video with id: $id');
      }

      // Ottieni un modello a partire dai dati dello snapshot
      final videoModel = HorizontalVideoModel.fromMap(videoSnapshot.data()!);

      // Ritorna il modello
      return videoModel;
    } catch (e) {
      throw GetHorizontalVideoByIdRemoteException(
          'An error occurred while getting video with id $id: $e');
    }
  }

  @override
  Future<HorizontalVideoModel> uploadVideo({
    required String userId,
    required File videoFile,
    required File thumbnailFile,
    required String title,
    String description = '',
    List<String> tags = const [],
    String category = '',
    String privacy = '',
    required bool isLive,
    required bool isMonetized,
  }) async {
    try {
      // Assicurati che l'id dell'utente che sta pubblicando sia valido
      if (userId == '') {
        throw const UploadHorizontalVideoRemoteException('Incorrect user id');
      }

      // Assicurati che il file video esista
      if (videoFile.existsSync()) {
        throw UploadHorizontalVideoRemoteException(
            'The video file $videoFile does not exists');
      }

      // Assicurati che il file thumbnail esista
      if (thumbnailFile.existsSync()) {
        throw UploadHorizontalVideoRemoteException(
            'The thumbnail file $thumbnailFile does not exists');
      }

      // Assicurati che il titolo sia valido
      if (title == '') {
        throw const UploadHorizontalVideoRemoteException('Incorrect title');
      }

      // Ottieni il formato del video
      final videoFormat = (lookupMimeType(videoFile.path))?.split('/').last;

      // Assicurati che il formato del video sia valido
      if (videoFormat == null) {
        throw const UnsupportedFileFormatException(
            'Unsupported video file format');
      }

      // Ottieni il formato della thumbnail
      final thumbnailFormat =
          (lookupMimeType(thumbnailFile.path))?.split('/').last;

      // Assicurati che il formato della thumbnail sia valida
      if (thumbnailFormat == null) {
        throw const UnsupportedFileFormatException(
            'Unsupported thumbnail file format');
      }

      // Ottieni un riferimento alla collezzione di video orizzontali
      final videoCollectionRef =
          _firestore.collection(FirebaseCollectionsLabels.horizontalVideos);

      // Crea un documento vuoto nel database
      final docRef = videoCollectionRef.doc();
      // Ottieni l'id del documento creato
      final docId = docRef.id;

      // Ottieni un riferimento alla cartella di storage nel database
      final videoStorageRef = _storage
          .ref()
          .child('${FirebaseCollectionsLabels.horizontalVideos}/$docId');

      // Carica la thumbnail su firebase storage
      final thumbnailSnapshot = await videoStorageRef
          .child('thumbnail.$thumbnailFormat')
          .putFile(thumbnailFile);

      // Ottieni l'url di download della thumbnail
      final thumbnailUrl = await thumbnailSnapshot.ref.getDownloadURL();

      // Carica il video su firebase storage
      final videoSnapshot =
          await videoStorageRef.child('video.$videoFormat').putFile(videoFile);
      // Ottieni l'url di download del video
      final videoUrl = await videoSnapshot.ref.getDownloadURL();

      // Ottieni le dimensioni del file video
      final videoSize = await videoFile.length();

      // Crea un controller video per ottenere informazioni aggiuntive sul video
      final videoPlayerController = VideoPlayerController.file(videoFile);
      // Inizializza il controller video
      await videoPlayerController.initialize();

      // Ottieni la durata del video
      final videoDuration = videoPlayerController.value.duration;
      // Ottieni la risoluzione del video
      final videoResolution = videoPlayerController.value.size;
      // Ottieni l'aspect ratio del video
      final videoAspectRatio = videoPlayerController.value.aspectRatio;

      // Distruggi il video player
      videoPlayerController.dispose();

      // Crea il modello del video
      final videoModel = HorizontalVideoModel(
        id: docId,
        userInfoModel: HorizontalVideoUserInfoModel(
          userId: userId,
        ),
        detailsModel: HorizontalVideoDetailsModel(
          title: title,
          description: description,
          tags: tags,
          category: category,
          privacy: privacy,
        ),
        fileInfoModel: HorizontalVideoFileInfoModel(
          videoUrl: videoUrl,
          thumbnailUrl: thumbnailUrl,
          duration: videoDuration,
          size: videoSize,
          format: videoFormat,
          resolution: videoResolution,
          aspectRatio: videoAspectRatio,
        ),
        metadataModel: HorizontalVideoMetadataModel(
          uploadDate: DateTime.now(),
          lastModifiedDate: DateTime.now(),
        ),
        stateModel: HorizontalVideoStateModel(
          isLive: isLive,
          isMonetized: isMonetized,
        ),
        advancedStatsModel: const HorizontalVideoAdvancedStatsModel(),
        userInteractionsModel: const HorizontalVideoUserInteractionsModel(),
      );

      // Crea il documento nel database
      await docRef.set(videoModel.toMap());

      // Ritorna il modello creato
      return videoModel;
    } catch (e) {
      throw UploadHorizontalVideoRemoteException(
          'An error occurred while uploading video: $e');
    }
  }

  @override
  Future<void> updateVideo(HorizontalVideoModel videoModel) async {
    try {
      // Ottieni un riferimento al documento
      final videoRef = _getVideoDocumentReference(videoModel.id);

      // Aggiorna il documento nel database con i nuovi valori
      await videoRef.update(videoModel.toMap());
    } catch (e) {
      throw UpdateHorizontalVideoRemoteException(
          'An error occurred while updating video with id ${videoModel.id}: $e');
    }
  }

  @override
  Future<void> deleteVideo(String id) async {
    try {
      // Ottieni un riferimento al documento
      final videoRef = _getVideoDocumentReference(id);

      // Cancella il documento
      await videoRef.delete();
    } catch (e) {
      throw UploadHorizontalVideoRemoteException(
          'An error occurred while deleting video with id $id: $e');
    }
  }

  List<HorizontalVideoModel> _getModelsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    try {
      // Assicurati che lo snapshot contenga dei dati
      if (snapshot.docs.isEmpty) {
        throw const HorizontalVideoNotFoundRemoteException(
            'The horizontal video snapshot is empty');
      }

      // Crea una lista di video orizzontali a partire dai documenti dello snapshot
      final videoModels = snapshot.docs.map(
        (doc) {
          // Assicurati che il documento esista e che contenga dei dati
          if (!doc.exists || doc.data().isEmpty) {
            throw HorizontalVideoNotFoundRemoteException(
                'An error occurred while mapping the doc: $doc to the horizontal video model');
          }

          // Ritorna il modello a partire dal documento
          return HorizontalVideoModel.fromMap(doc.data());
        },
      ).toList();

      // Ritorna la lista di modelli
      return videoModels;
    } catch (e) {
      throw HorizontalVideoRemoteException(
          'An error occurred while getting video models from snapshot $snapshot: $e');
    }
  }

  DocumentReference<Map<String, dynamic>> _getVideoDocumentReference(
      String documentId) {
    try {
      // Assicurati che l'id fornito sia valido
      if (documentId == '') {
        throw HorizontalVideoNotFoundRemoteException(
            'Invalid document id: $documentId');
      }

      // Ritorna il riferimento al documento
      return _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .doc(documentId);
    } catch (e) {
      throw HorizontalVideoNotFoundRemoteException(
          'Unable to find the document with id: $documentId');
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      _getVideoCollectionSnapshot() async {
    try {
      return await _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .get();
    } catch (e) {
      throw const HorizontalVideoNotFoundRemoteException(
          'Unable to get the horizonal video collection');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getVideoDocumentSnapshot(
      String documentId) async {
    try {
      // Assicurati che l'id del documento sia valido
      if (documentId == '') {
        throw HorizontalVideoNotFoundRemoteException(
            'Invalid document id: $documentId');
      }

      // Ritorna lo snapshot del documento richiesto
      return await _firestore
          .collection(FirebaseCollectionsLabels.horizontalVideos)
          .doc(documentId)
          .get();
    } catch (e) {
      throw const HorizontalVideoNotFoundRemoteException(
          'Unable to get the video\'s document snapshot');
    }
  }
}
