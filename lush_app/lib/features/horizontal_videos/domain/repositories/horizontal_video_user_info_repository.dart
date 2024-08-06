import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_info_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_info.dart';

abstract interface class HorizontalVideoUserInfoRepository
    implements
        Repository<HorizontalVideoUserInfo, HorizontalVideoUserInfoModel> {}
