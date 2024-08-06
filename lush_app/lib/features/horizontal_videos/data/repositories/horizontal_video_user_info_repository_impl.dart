import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_info_model.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_info.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_user_info_repository.dart';

class HorizontalVideoUserInfoRepositoryImpl
    implements HorizontalVideoUserInfoRepository {
  @override
  HorizontalVideoUserInfo toEntity(HorizontalVideoUserInfoModel model) {
    return HorizontalVideoUserInfo(
      userId: model.userId,
    );
  }

  @override
  HorizontalVideoUserInfoModel toModel(HorizontalVideoUserInfo entity) {
    return HorizontalVideoUserInfoModel(
      userId: entity.userId,
    );
  }
}
