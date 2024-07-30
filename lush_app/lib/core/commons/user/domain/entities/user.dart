import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

import 'package:lush_app/core/commons/user/domain/entities/user_info/user_chat_info.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_contact_info.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_personal_info.dart';

@immutable
class User extends Equatable {
  final String id;
  final UserPersonalInfo personalInfo;
  final UserContactInfo contactInfo;
  final UserChatInfo chatInfo;

  const User({
    required this.id,
    required this.personalInfo,
    required this.contactInfo,
    required this.chatInfo,
  });

  User copyWith({
    String? id,
    UserPersonalInfo? personalInfo,
    UserContactInfo? contactInfo,
    UserChatInfo? chatInfo,
  }) {
    return User(
      id: id ?? this.id,
      personalInfo: personalInfo ?? this.personalInfo,
      contactInfo: contactInfo ?? this.contactInfo,
      chatInfo: chatInfo ?? this.chatInfo,
    );
  }

  @override
  List<Object?> get props => [id, personalInfo, contactInfo, chatInfo];
}
