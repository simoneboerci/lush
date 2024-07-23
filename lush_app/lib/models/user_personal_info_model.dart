import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum UserPersonalInfoField {
  name,
  surname,
  fiscalCode,
  birthDate,
  birthAddress,
  residenceAddress,
}

@immutable
class UserPersonalInfoModel extends Equatable {
  final String? name;
  final String? surname;
  final String? fiscalCode;
  final DateTime? birthDate;
  final String? birthAddress;
  final String? residenceAddress;

  const UserPersonalInfoModel({
    this.name,
    this.surname,
    this.fiscalCode,
    this.birthDate,
    this.birthAddress,
    this.residenceAddress,
  });

  factory UserPersonalInfoModel.fromMap(Map<String, dynamic> map) {
    return UserPersonalInfoModel(
      name: map[UserPersonalInfoField.name.name] as String?,
      surname: map[UserPersonalInfoField.surname.name] as String?,
      fiscalCode: map[UserPersonalInfoField.fiscalCode.name] as String?,
      birthDate: map[UserPersonalInfoField.birthDate.name] != null
          ? (map[UserPersonalInfoField.birthDate.name] as Timestamp).toDate()
          : null,
      birthAddress: map[UserPersonalInfoField.birthAddress.name] as String?,
      residenceAddress:
          map[UserPersonalInfoField.residenceAddress.name] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserPersonalInfoField.name.name: name,
      UserPersonalInfoField.surname.name: surname,
      UserPersonalInfoField.fiscalCode.name: fiscalCode,
      UserPersonalInfoField.birthDate.name:
          birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      UserPersonalInfoField.birthAddress.name: birthAddress,
      UserPersonalInfoField.residenceAddress.name: residenceAddress,
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

  @override
  List<Object?> get props =>
      [name, surname, fiscalCode, birthDate, birthAddress, residenceAddress];
}
