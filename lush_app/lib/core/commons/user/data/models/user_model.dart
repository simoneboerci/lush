import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

import 'package:lush_app/core/commons/user/data/models/user_chat_info_model.dart';
import 'package:lush_app/core/commons/user/data/models/user_contact_info_model.dart';
import 'package:lush_app/core/commons/user/data/models/user_personal_info_model.dart';

enum UserModelField {
  id,
  personalInfo,
  contactInfo,
  chatInfo,
}

@immutable
class UserModel extends Equatable {
  final String id;
  final UserPersonalInfoModel personalInfo;
  final UserContactInfoModel contactInfo;
  final UserChatInfoModel chatInfo;

  const UserModel({
    required this.id,
    required this.personalInfo,
    required this.contactInfo,
    required this.chatInfo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[UserModelField.id.name] ?? '',
      personalInfo:
          UserPersonalInfoModel.fromMap(map[UserModelField.personalInfo.name]),
      contactInfo:
          UserContactInfoModel.fromMap(map[UserModelField.contactInfo.name]),
      chatInfo: UserChatInfoModel.fromMap(map[UserModelField.chatInfo.name]),
    );
  }

  factory UserModel.fromFirebaseUser(User user, {String? password}) {
    return UserModel(
      id: user.uid,
      personalInfo: const UserPersonalInfoModel(),
      contactInfo: UserContactInfoModel(
        email: user.email,
        password: password,
        phoneNumber: user.phoneNumber,
      ),
      chatInfo: UserChatInfoModel.online().copyWith(username: user.displayName),
    );
  }

  factory UserModel.empty(String userId) {
    return UserModel(
      id: userId,
      personalInfo: const UserPersonalInfoModel(),
      contactInfo: const UserContactInfoModel(),
      chatInfo: UserChatInfoModel.online(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserModelField.id.name: id,
      UserModelField.personalInfo.name: personalInfo.toMap(),
      UserModelField.contactInfo.name: contactInfo.toMap(),
      UserModelField.chatInfo.name: chatInfo.toMap(),
    };
  }

  UserModel copyWith({
    String? id,
    UserPersonalInfoModel? personalInfo,
    UserContactInfoModel? contactInfo,
    UserChatInfoModel? chatInfo,
  }) {
    return UserModel(
      id: id ?? this.id,
      personalInfo: personalInfo ?? this.personalInfo,
      contactInfo: contactInfo ?? this.contactInfo,
      chatInfo: chatInfo ?? this.chatInfo,
    );
  }

  @override
  List<Object?> get props => [id, personalInfo, contactInfo, chatInfo];
}
