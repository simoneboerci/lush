import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_state_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_state.dart';

abstract interface class HorizontalVideoStateRepository
    implements Repository<HorizontalVideoState, HorizontalVideoStateModel> {}
