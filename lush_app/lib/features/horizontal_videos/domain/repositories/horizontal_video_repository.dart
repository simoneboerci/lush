import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';

abstract interface class HorizontalVideoRepository
    implements Repository<HorizontalVideo, HorizontalVideoModel> {
  Future<Either<Failure, List<HorizontalVideo>>> getAllVideos();
  Future<Either<Failure, List<HorizontalVideo>>> fetchVideos(
      {String? lastDocumentId, int pageSize = 20});

  Future<Either<Failure, HorizontalVideo>> getVideoById(String id);

  Future<Either<Failure, HorizontalVideo>> uploadVideo({
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
  });

  Future<Either<Failure, HorizontalVideo>> updateVideo(HorizontalVideo video);
  Future<Either<Failure, HorizontalVideo>> deleteVideo(String id);
}
