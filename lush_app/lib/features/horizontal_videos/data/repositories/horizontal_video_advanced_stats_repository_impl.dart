import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_advanced_stats_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_advanced_stats.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_advanced_stats_repository.dart';

class HorizontalVideoAdvancedStatsRepositoryImpl
    implements HorizontalVideoAdvancedStatsRepository {
  @override
  HorizontalVideoAdvancedStats toEntity(
      HorizontalVideoAdvancedStatsModel model) {
    return HorizontalVideoAdvancedStats(
      averageWatchTime: model.averageWatchTime,
      completionRate: model.completionRate,
      audienceRetention: model.audienceRetention,
    );
  }

  @override
  HorizontalVideoAdvancedStatsModel toModel(
      HorizontalVideoAdvancedStats entity) {
    return HorizontalVideoAdvancedStatsModel(
      averageWatchTime: entity.averageWatchTime,
      completionRate: entity.completionRate,
      audienceRetention: entity.audienceRetention,
    );
  }
}
