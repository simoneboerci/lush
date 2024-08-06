import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_state_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_state.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_state_repository.dart';

class HorizontalVideoStateRepositoryImpl
    implements HorizontalVideoStateRepository {
  @override
  HorizontalVideoState toEntity(HorizontalVideoStateModel model) {
    return HorizontalVideoState(
      isLive: model.isLive,
      isArchived: model.isArchived,
      isMonetized: model.isMonetized,
      monetizationDetails: model.monetizationDetails,
    );
  }

  @override
  HorizontalVideoStateModel toModel(HorizontalVideoState entity) {
    return HorizontalVideoStateModel(
      isLive: entity.isLive,
      isArchived: entity.isArchived,
      isMonetized: entity.isMonetized,
      monetizationDetails: entity.monetizationDetails,
    );
  }
}
