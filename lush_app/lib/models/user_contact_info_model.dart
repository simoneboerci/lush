import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

enum UserContactInfoField {
  email,
  password,
  phoneNumber,
}

@immutable
class UserContactInfoModel extends Equatable {
  final String? email;
  final String? password;
  final String? phoneNumber;

  const UserContactInfoModel({
    this.email,
    this.password,
    this.phoneNumber,
  });

  factory UserContactInfoModel.fromEmailAndPassword(
      String email, String password) {
    return UserContactInfoModel(
      email: email,
      password: password,
    );
  }

  factory UserContactInfoModel.fromMap(Map<String, dynamic> map) {
    return UserContactInfoModel(
      email: map[UserContactInfoField.email.name] as String?,
      password: map[UserContactInfoField.password.name] as String?,
      phoneNumber: map[UserContactInfoField.phoneNumber.name] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserContactInfoField.email.name: email,
      UserContactInfoField.password.name: password,
      UserContactInfoField.phoneNumber.name: phoneNumber,
    };
  }

  UserContactInfoModel copyWith({
    String? email,
    String? password,
    String? phoneNumber,
  }) {
    return UserContactInfoModel(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [email, password, phoneNumber];
}
