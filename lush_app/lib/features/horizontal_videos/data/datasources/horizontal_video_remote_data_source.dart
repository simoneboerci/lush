import 'dart:io';

import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';

abstract interface class HorizontalVideoRemoteDataSource {
  Future<List<HorizontalVideoModel>> getAllVideos();
  Future<List<HorizontalVideoModel>> fetchVideos(
      {String? lastDocumentId, int pageSize = 20});

  Future<HorizontalVideoModel> getVideoById(String id);

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
  });
  Future<void> updateVideo(HorizontalVideoModel videoModel);
  Future<void> deleteVideo(String id);
}
