import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_model.dart';

abstract interface class HorizontalVideoDataSource {
  Future<List<HorizontalVideoModel>> getHorizontalVideos();
  Future<HorizontalVideoModel> getHorizontalVideoById(String id);

  Future<String> uploadHorizontalVideoThumbnail(
    String filePath,
    String fileName,
  );

  Future<HorizontalVideoModel> uploadHorizontalVideo(
    String filePath,
    String fileName,
    String thumbnailUrl,
    String title,
  );
}
