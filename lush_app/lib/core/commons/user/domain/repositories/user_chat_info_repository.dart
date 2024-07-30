import 'package:lush_app/core/repository.dart';
import 'package:lush_app/core/commons/user/data/models/user_chat_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_chat_info.dart';

abstract class UserChatInfoRepository
    implements Repository<UserChatInfo, UserChatInfoModel> {}
