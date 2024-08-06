import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_details_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_details.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_details_repository.dart';

class HorizontalVideoDetailsRepositoryImpl
    implements HorizontalVideoDetailsRepository {
  @override
  HorizontalVideoDetails toEntity(HorizontalVideoDetailsModel model) {
    return HorizontalVideoDetails(
      title: model.title,
      description: model.description,
      tags: model.tags,
      category: model.category,
      privacy: model.privacy,
    );
  }

  @override
  HorizontalVideoDetailsModel toModel(HorizontalVideoDetails entity) {
    return HorizontalVideoDetailsModel(
      title: entity.title,
      description: entity.description,
      tags: entity.tags,
      category: entity.category,
      privacy: entity.privacy,
    );
  }
}
