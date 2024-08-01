import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/horizontal_videos/data/datasources/horizontal_video_data_source.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class HorizontalVideoRepositoryImpl implements HorizontalVideoRepository {
  final HorizontalVideoDataSource horizontalVideoDataSource;

  const HorizontalVideoRepositoryImpl(this.horizontalVideoDataSource);

  @override
  HorizontalVideo toEntity(HorizontalVideoModel model) {
    return HorizontalVideo(
      id: model.id,
      url: model.url,
      thumbnaillUrl: model.thumbnailUrl,
    );
  }

  @override
  HorizontalVideoModel toModel(HorizontalVideo entity) {
    return HorizontalVideoModel(
      id: entity.id,
      url: entity.url,
      thumbnailUrl: entity.thumbnaillUrl,
    );
  }

  @override
  Future<Either<Failure, List<HorizontalVideo>>> getHorizontalVideos() async {
    try {
      final videoModels = await horizontalVideoDataSource.getHorizontalVideos();
      final videos = videoModels.map((model) => toEntity(model)).toList();
      return right(videos);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> getHorizontalVideoById(
      String id) async {
    try {
      final videoModel =
          await horizontalVideoDataSource.getHorizontalVideoById(id);
      return right(toEntity(videoModel));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HorizontalVideo>> uploadHorizontalVideos(
    String filePath,
    String fileName,
    String thumbnailUrl,
  ) async {
    try {
      final videoModel = await horizontalVideoDataSource.uploadHorizontalVideo(
          filePath, fileName, thumbnailUrl);
      return right(toEntity(videoModel));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
