import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_details_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_details.dart';

abstract interface class HorizontalVideoDetailsRepository
    implements
        Repository<HorizontalVideoDetails, HorizontalVideoDetailsModel> {}
