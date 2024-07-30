import 'package:lush_app/core/commons/user/data/models/user_personal_info_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_personal_info.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_personal_info_repository.dart';

class UserPersonalInfoRepositoryImpl implements UserPersonalInfoRepository {
  @override
  UserPersonalInfo toEntity(UserPersonalInfoModel model) {
    return UserPersonalInfo(
      name: model.name,
      surname: model.surname,
      fiscalCode: model.fiscalCode,
      birthDate: model.birthDate,
      birthAddress: model.birthAddress,
      residenceAddress: model.residenceAddress,
    );
  }

  @override
  UserPersonalInfoModel toModel(UserPersonalInfo entity) {
    return UserPersonalInfoModel(
      name: entity.name,
      surname: entity.surname,
      fiscalCode: entity.fiscalCode,
      birthDate: entity.birthDate,
      birthAddress: entity.birthAddress,
      residenceAddress: entity.residenceAddress,
    );
  }
}
