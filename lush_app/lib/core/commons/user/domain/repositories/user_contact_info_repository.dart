import 'package:lush_app/core/repository.dart';
import 'package:lush_app/core/commons/user/data/models/user_contact_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_contact_info.dart';

abstract class UserContactInfoRepository
    implements Repository<UserContactInfo, UserContactInfoModel> {}
