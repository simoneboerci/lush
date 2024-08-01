import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';

abstract interface class HorizontalVideoRepository
    implements Repository<HorizontalVideo, HorizontalVideoModel> {
  Future<Either<Failure, List<HorizontalVideo>>> getHorizontalVideos(
      {String? lastVideoId});
  Future<Either<Failure, HorizontalVideo>> getHorizontalVideoById(String id);

  Future<Either<Failure, HorizontalVideo>> uploadHorizontalVideos(
    String filePath,
    String fileName,
    String thumbnailUrl,
    String title,
  );
}
