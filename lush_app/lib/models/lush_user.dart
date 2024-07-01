import 'package:cloud_firestore/cloud_firestore.dart';

class LushUser {
  final String userId;

  String? name;
  String? surname;
  DateTime? birthDate;
  String? birthAddress;
  String? residenceAddress;

  String? username;
  String? email;
  String? password;
  String? phoneNumber;

  LushUser({
    required this.userId,
    this.username,
    this.name,
    this.surname,
    this.birthDate,
    this.birthAddress,
    this.residenceAddress,
    this.email,
    this.password,
    this.phoneNumber,
  });

  factory LushUser.copyWith({
    required LushUser user,
    String? name,
    String? surname,
    DateTime? birthDate,
    String? birthAddress,
    String? residenceAddress,
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
  }) {
    return LushUser(
      userId: user.userId,
      name: name ?? user.name,
      surname: surname ?? user.surname,
      birthDate: birthDate ?? user.birthDate,
      birthAddress: birthAddress ?? user.birthAddress,
      username: username ?? user.username,
      email: email ?? user.email,
      password: password ?? user.password,
      residenceAddress: residenceAddress ?? user.residenceAddress,
      phoneNumber: phoneNumber ?? user.phoneNumber,
    );
  }

  factory LushUser.fromMap(Map<String, dynamic> map) {
    Timestamp birthDate = map['birth_date'];
    return LushUser(
      userId: map['userId'],
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      password: map['password'],
      birthDate: birthDate.toDate(),
      birthAddress: map['birth_address'],
      residenceAddress: map['residence_address'],
      phoneNumber: map['phone_number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'birth_address': birthAddress,
      'residence_address': residenceAddress,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
    };
  }
}
