import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/data/datasources/user_remote_data_source.dart';
import 'package:lush_app/core/exceptions/horizontal_video_exceptions.dart';
import 'package:lush_app/core/exceptions/user_remote_exceptions.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/horizontal_videos/data/datasources/horizontal_video_remote_data_source.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_advanced_stats_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_details_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_file_info_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_metadata_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_state_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_user_info_repository.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_user_interactions_repository.dart';

class HorizontalVideoRepositoryImpl implements HorizontalVideoRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final HorizontalVideoRemoteDataSource horizontalVideoRemoteDataSource;

  final HorizontalVideoAdvancedStatsRepository
      horizontalVideoAdvancedStatsRepository;
  final HorizontalVideoDetailsRepository horizontalVideoDetailsRepository;
  final HorizontalVideoFileInfoRepository horizontalVideoFileInfoRepository;
  final HorizontalVideoMetadataRepository horizontalVideoMetadataRepository;
  final HorizontalVideoStateRepository horizontalVideoStateRepository;
  final HorizontalVideoUserInfoRepository horizontalVideoUserInfoRepository;
  final HorizontalVideoUserInteractionsRepository
      horizontalVideoUserInteractionsRepository;

  const HorizontalVideoRepositoryImpl({
    required this.userRemoteDataSource,
    required this.horizontalVideoRemoteDataSource,
    required this.horizontalVideoAdvancedStatsRepository,
    required this.horizontalVideoDetailsRepository,
    required this.horizontalVideoFileInfoRepository,
    required this.horizontalVideoMetadataRepository,
    required this.horizontalVideoStateRepository,
    required this.horizontalVideoUserInfoRepository,
    required this.horizontalVideoUserInteractionsRepository,
  });

  @override
  HorizontalVideo toEntity(HorizontalVideoModel model) {
    return HorizontalVideo(
      id: model.id,
      userInfo: horizontalVideoUserInfoRepository.toEntity(model.userInfoModel),
      details: horizontalVideoDetailsRepository.toEntity(model.detailsModel),
      fileInfo: horizontalVideoFileInfoRepository.toEntity(model.fileInfoModel),
      metadata: horizontalVideoMetadataRepository.toEntity(model.metadataModel),
      state: horizontalVideoStateRepository.toEntity(model.stateModel),
      advancedStats: horizontalVideoAdvancedStatsRepository
          .toEntity(model.advancedStatsModel),
      userInteractions: horizontalVideoUserInteractionsRepository
          .toEntity(model.userInteractionsModel),
    );
  }

  @override
  HorizontalVideoModel toModel(HorizontalVideo entity) {
    return HorizontalVideoModel(
      id: entity.id,
      userInfoModel: horizontalVideoUserInfoRepository.toModel(entity.userInfo),
      detailsModel: horizontalVideoDetailsRepository.toModel(entity.details),
      fileInfoModel: horizontalVideoFileInfoRepository.toModel(entity.fileInfo),
      metadataModel: horizontalVideoMetadataRepository.toModel(entity.metadata),
      stateModel: horizontalVideoStateRepository.toModel(entity.state),
      advancedStatsModel:
          horizontalVideoAdvancedStatsRepository.toModel(entity.advancedStats),
      userInteractionsModel: horizontalVideoUserInteractionsRepository
          .toModel(entity.userInteractions),
    );
  }

  @override
  Future<Either<Failure, List<HorizontalVideo>>> getAllVideos() async {
    try {
      // Ottieni la lista di modelli video
      final videoModels = await horizontalVideoRemoteDataSource.getAllVideos();

      // Genera una lista di video dai modelli
      final videos = videoModels.map((model) => toEntity(model)).toList();

      // Ritorna la lista di video
      return right(videos);
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HorizontalVideo>>> fetchVideos(
      {String? lastDocumentId, int pageSize = 20}) async {
    try {
      // Ottieni la lista di modelli video
      final videoModels = await horizontalVideoRemoteDataSource.fetchVideos(
        lastDocumentId: lastDocumentId,
        pageSize: pageSize,
      );

      // Genera una lista di video dai modelli
      final videos = videoModels.map((model) => toEntity(model)).toList();

      // Ritorna la lista di video
      return right(videos);
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> getVideoById(String id) async {
    try {
      // Ottieni il modello di video
      final videoModel = await horizontalVideoRemoteDataSource.getVideoById(id);

      // Genera un video a partire dal modello
      final video = toEntity(videoModel);

      // Ritorna il video
      return right(video);
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> uploadVideo(
      {required String userId,
      required File videoFile,
      required File thumbnailFile,
      required String title,
      String description = '',
      List<String> tags = const [],
      String category = '',
      String privacy = '',
      required bool isLive,
      required bool isMonetized}) async {
    try {
      try {
        // Assicurati che l'utente esista nel database
        await userRemoteDataSource.getUserById(userId);
      } on UserRemoteException catch (e) {
        return left(Failure(message: e.toString()));
      }

      // Carica il video nel database e ottieni il modello del video caricato
      final videoModel = await horizontalVideoRemoteDataSource.uploadVideo(
        userId: userId,
        videoFile: videoFile,
        thumbnailFile: thumbnailFile,
        title: title,
        description: description,
        tags: tags,
        category: category,
        privacy: privacy,
        isLive: isLive,
        isMonetized: isMonetized,
      );

      // Genera un video a partire dal modello
      final video = toEntity(videoModel);

      // Ritorna il video
      return right(video);
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> updateVideo(
      HorizontalVideo video) async {
    try {
      // Genera un modello a partire dal video
      final videoModel = toModel(video);

      // Aggiorna il video nel database
      await horizontalVideoRemoteDataSource.updateVideo(videoModel);

      // Ritorna il video aggiornato
      return right(video);
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> deleteVideo(String id) async {
    try {
      // Ottieni il video da eliminare
      final video = await getVideoById(id);

      // Elimina il video dal database
      await horizontalVideoRemoteDataSource.deleteVideo(id);

      // Ritorna il video eliminato
      return video;
    } on HorizontalVideoRemoteException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
