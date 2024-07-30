import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

@immutable
class UserContactInfo extends Equatable {
  final String? email;
  final String? password;
  final String? phoneNumber;

  const UserContactInfo({
    this.email,
    this.password,
    this.phoneNumber,
  });

  UserContactInfo copyWith({
    String? email,
    String? password,
    String? phoneNumber,
  }) {
    return UserContactInfo(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [email, password, phoneNumber];
}
