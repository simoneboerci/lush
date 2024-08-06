import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_interactions_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_interactions.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_user_interactions_repository.dart';

class HorizontalVideoUserInteractionsRepositoryImpl
    implements HorizontalVideoUserInteractionsRepository {
  @override
  HorizontalVideoUserInteractions toEntity(
      HorizontalVideoUserInteractionsModel model) {
    return HorizontalVideoUserInteractions(
      userInteractions: model.userInteractions,
      isFlagged: model.isFlagged,
      flagDetails: model.flagDetails,
    );
  }

  @override
  HorizontalVideoUserInteractionsModel toModel(
      HorizontalVideoUserInteractions entity) {
    return HorizontalVideoUserInteractionsModel(
      userInteractions: entity.userInteractions,
      isFlagged: entity.isFlagged,
      flagDetails: entity.flagDetails,
    );
  }
}
