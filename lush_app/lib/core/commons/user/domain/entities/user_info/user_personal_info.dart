import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

@immutable
class UserPersonalInfo extends Equatable {
  final String? name;
  final String? surname;
  final String? fiscalCode;
  final DateTime? birthDate;
  final String? birthAddress;
  final String? residenceAddress;

  const UserPersonalInfo({
    this.name,
    this.surname,
    this.fiscalCode,
    this.birthDate,
    this.birthAddress,
    this.residenceAddress,
  });

  UserPersonalInfo copyWith({
    String? name,
    String? surname,
    String? fiscalCode,
    DateTime? birthDate,
    String? birthAddress,
    String? residenceAddress,
  }) {
    return UserPersonalInfo(
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
