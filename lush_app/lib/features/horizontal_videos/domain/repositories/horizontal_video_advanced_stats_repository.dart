import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_advanced_stats_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_advanced_stats.dart';

abstract interface class HorizontalVideoAdvancedStatsRepository
    implements
        Repository<HorizontalVideoAdvancedStats,
            HorizontalVideoAdvancedStatsModel> {}
