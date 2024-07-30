import 'package:lush_app/core/commons/user/data/models/user_chat_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_chat_info.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_chat_info_repository.dart';

class UserChatInfoRepositoryImpl implements UserChatInfoRepository {
  @override
  UserChatInfo toEntity(UserChatInfoModel model) {
    return UserChatInfo(
      username: model.username,
      profilePictureUrl: model.profilePictureUrl,
      lastSeen: model.lastSeen,
      activeChatsIds: model.activeChatsIds,
      isOnline: model.isOnline,
    );
  }

  @override
  UserChatInfoModel toModel(UserChatInfo entity) {
    return UserChatInfoModel(
      username: entity.username,
      profilePictureUrl: entity.profilePictureUrl,
      lastSeen: entity.lastSeen,
      activeChatsIds: entity.activeChatsIds,
      isOnline: entity.isOnline,
    );
  }
}
