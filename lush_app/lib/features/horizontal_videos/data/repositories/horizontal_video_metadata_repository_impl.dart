import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_metadata_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_metadata.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_metadata_repository.dart';

class HorizontalVideoMetadataRepositoryImpl
    implements HorizontalVideoMetadataRepository {
  @override
  HorizontalVideoMetadata toEntity(HorizontalVideoMetadataModel model) {
    return HorizontalVideoMetadata(
      uploadDate: model.uploadDate,
      lastModifiedDate: model.lastModifiedDate,
      viewsCount: model.viewsCount,
      likesCount: model.likesCount,
      dislikesCount: model.dislikesCount,
      commentsCount: model.commentsCount,
      sharesCount: model.sharesCount,
      addToFavoritesCount: model.addToFavoritesCount,
    );
  }

  @override
  HorizontalVideoMetadataModel toModel(HorizontalVideoMetadata entity) {
    return HorizontalVideoMetadataModel(
      uploadDate: entity.uploadDate,
      lastModifiedDate: entity.lastModifiedDate,
      viewsCount: entity.viewsCount,
      likesCount: entity.likesCount,
      dislikesCount: entity.dislikesCount,
      commentsCount: entity.commentsCount,
      sharesCount: entity.sharesCount,
      addToFavoritesCount: entity.addToFavoritesCount,
    );
  }
}
