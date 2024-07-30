import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserChatInfoField {
  username,
  profilePictureUrl,
  lastSeen,
  activeChatsIds,
  isOnline,
}

@immutable
class UserChatInfoModel extends Equatable {
  final String? username;
  final String? profilePictureUrl;
  final DateTime lastSeen;
  final List<String> activeChatsIds;
  final bool isOnline;

  const UserChatInfoModel({
    this.username,
    this.profilePictureUrl,
    required this.lastSeen,
    this.activeChatsIds = const [],
    required this.isOnline,
  });

  factory UserChatInfoModel.online() {
    return UserChatInfoModel(lastSeen: DateTime.now(), isOnline: true);
  }

  factory UserChatInfoModel.fromMap(Map<String, dynamic> map) {
    return UserChatInfoModel(
      username: map[UserChatInfoField.username.name] as String?,
      profilePictureUrl:
          map[UserChatInfoField.profilePictureUrl.name] as String?,
      lastSeen: map[UserChatInfoField.lastSeen.name] != null
          ? (map[UserChatInfoField.lastSeen.name] as Timestamp).toDate()
          : DateTime.now(),
      activeChatsIds: map[UserChatInfoField.activeChatsIds.name] != null
          ? List<String>.from(
              map[UserChatInfoField.activeChatsIds.name] as List<dynamic>)
          : const [],
      isOnline: map[UserChatInfoField.isOnline.name] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserChatInfoField.username.name: username,
      UserChatInfoField.profilePictureUrl.name: profilePictureUrl,
      UserChatInfoField.lastSeen.name: lastSeen,
      UserChatInfoField.activeChatsIds.name: activeChatsIds,
      UserChatInfoField.isOnline.name: isOnline,
    };
  }

  UserChatInfoModel copyWith({
    String? username,
    String? profilePictureUrl,
    DateTime? lastSeen,
    List<String>? activeChatsIds,
    bool? isOnline,
  }) {
    return UserChatInfoModel(
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      lastSeen: lastSeen ?? this.lastSeen,
      activeChatsIds: activeChatsIds ?? this.activeChatsIds,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  /*Tuple2<UserChatInfoModel, bool> addActiveChat(String chatId) {
    if (activeChatsIds.contains(chatId)) {
      return Tuple2(this, false);
    } else {
      return Tuple2(
        copyWith(activeChatsIds: [...activeChatsIds, chatId]),
        true,
      );
    }
  }

  Tuple2<UserChatInfoModel, bool> removeActiveChat(String chatId) {
    if (activeChatsIds.contains(chatId)) {
      return Tuple2(
        copyWith(
            activeChatsIds:
                activeChatsIds.where((id) => id != chatId).toList()),
        true,
      );
    } else {
      return Tuple2(this, false);
    }
  }

  UserChatInfoModel setOnlineStatus(bool status) {
    return copyWith(
      isOnline: status,
      lastSeen: status ? DateTime.now() : lastSeen,
    );
  }

  NetworkImage? getProfilePicture() =>
      profilePictureUrl != null ? NetworkImage(profilePictureUrl!) : null;*/

  @override
  List<Object?> get props =>
      [username, profilePictureUrl, lastSeen, activeChatsIds, isOnline];
}
