import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_interactions_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_interactions.dart';

abstract interface class HorizontalVideoUserInteractionsRepository
    implements
        Repository<HorizontalVideoUserInteractions,
            HorizontalVideoUserInteractionsModel> {}
