import 'package:cloud_firestore/cloud_firestore.dart';

class UserPersonalInfoModel {
  final String? name;
  final String? surname;
  final String? fiscalCode;
  final DateTime? birthDate;
  final String? birthAddress;
  final String? residenceAddress;

  static const nameLabel = 'name';
  static const surnameLabel = 'surname';
  static const fiscalCodeLabel = 'fiscal_code';
  static const birthDateLabel = 'birth_date';
  static const birthAddressLabel = 'birth_address_label';
  static const residenceAddressLabel = 'residence_address_label';

  UserPersonalInfoModel({
    this.name,
    this.surname,
    this.fiscalCode,
    this.birthDate,
    this.birthAddress,
    this.residenceAddress,
  });

  factory UserPersonalInfoModel.fromMap(Map<String, dynamic> map) {
    return UserPersonalInfoModel(
      name: map[nameLabel] as String?,
      surname: map[surnameLabel] as String?,
      fiscalCode: map[fiscalCodeLabel] as String?,
      birthDate: map[birthDateLabel] != null
          ? (map[birthDateLabel] as Timestamp).toDate()
          : null,
      birthAddress: map[birthAddressLabel] as String?,
      residenceAddress: map[residenceAddressLabel] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserPersonalInfoModel.nameLabel: name,
      UserPersonalInfoModel.surnameLabel: surname,
      UserPersonalInfoModel.fiscalCodeLabel: fiscalCode,
      UserPersonalInfoModel.birthDateLabel:
          birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      UserPersonalInfoModel.birthAddressLabel: birthAddress,
      UserPersonalInfoModel.residenceAddressLabel: residenceAddress,
    };
  }

  UserPersonalInfoModel copyWith({
    String? name,
    String? surname,
    String? fiscalCode,
    DateTime? birthDate,
    String? birthAddress,
    String? residenceAddress,
  }) {
    return UserPersonalInfoModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      fiscalCode: fiscalCode ?? this.fiscalCode,
      birthDate: birthDate ?? this.birthDate,
      birthAddress: birthAddress ?? this.birthAddress,
      residenceAddress: residenceAddress ?? this.residenceAddress,
    );
  }
}
