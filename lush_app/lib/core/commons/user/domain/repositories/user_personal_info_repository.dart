import 'package:lush_app/core/repository.dart';
import 'package:lush_app/core/commons/user/data/models/user_personal_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_personal_info.dart';

abstract class UserPersonalInfoRepository
    implements Repository<UserPersonalInfo, UserPersonalInfoModel> {}
