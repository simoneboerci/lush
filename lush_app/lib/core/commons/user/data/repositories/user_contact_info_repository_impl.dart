import 'package:lush_app/core/commons/user/data/models/user_contact_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_contact_info.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_contact_info_repository.dart';

class UserContactInfoRepositoryImpl implements UserContactInfoRepository {
  @override
  UserContactInfo toEntity(UserContactInfoModel model) {
    return UserContactInfo(
      email: model.email,
      password: model.password,
      phoneNumber: model.phoneNumber,
    );
  }

  @override
  UserContactInfoModel toModel(UserContactInfo entity) {
    return UserContactInfoModel(
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
    );
  }
}
