import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_file_info_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_file_info.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_file_info_repository.dart';

class HorizontalVideoFileInfoRepositoryImpl
    implements HorizontalVideoFileInfoRepository {
  @override
  HorizontalVideoFileInfo toEntity(HorizontalVideoFileInfoModel model) {
    return HorizontalVideoFileInfo(
      videoUrl: model.videoUrl,
      thumbnailUrl: model.thumbnailUrl,
      duration: model.duration,
      size: model.size,
      format: model.format,
      resolution: model.resolution,
      aspectRatio: model.aspectRatio,
    );
  }

  @override
  HorizontalVideoFileInfoModel toModel(HorizontalVideoFileInfo entity) {
    return HorizontalVideoFileInfoModel(
      videoUrl: entity.videoUrl,
      thumbnailUrl: entity.thumbnailUrl,
      duration: entity.duration,
      size: entity.size,
      format: entity.format,
      resolution: entity.resolution,
      aspectRatio: entity.aspectRatio,
    );
  }
}
