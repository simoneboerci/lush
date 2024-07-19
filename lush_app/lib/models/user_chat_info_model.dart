import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class UserChatInfoModel {
  final String? username;
  final String? profilePictureUrl;
  final DateTime lastSeen;
  final List<String> activeChatsIds;
  final bool isOnline;

  static const String usernameLabel = 'username';
  static const String profilePictureUrlLabel = 'profile_picture_url';
  static const String lastSeenLabel = 'last_seen';
  static const String activeChatsIdsLabel = 'active_chats_ids';
  static const String isOnlineLabel = 'is_online';

  UserChatInfoModel({
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
      username: map[usernameLabel] as String?,
      profilePictureUrl: map[profilePictureUrlLabel] as String?,
      lastSeen: map[lastSeenLabel] != null
          ? (map[lastSeenLabel] as Timestamp).toDate()
          : DateTime.now(),
      activeChatsIds: map[activeChatsIdsLabel] != null
          ? List<String>.from(map[activeChatsIdsLabel] as List<dynamic>)
          : const [],
      isOnline: map[isOnlineLabel] != null ? map[isOnlineLabel] as bool : true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      usernameLabel: username,
      profilePictureUrlLabel: profilePictureUrl,
      lastSeenLabel: lastSeen,
      activeChatsIdsLabel: activeChatsIds,
      isOnlineLabel: isOnline,
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

  Tuple2<UserChatInfoModel, bool> addActiveChat(String chatId) {
    if (activeChatsIds.contains(chatId)) {
      return Tuple2(
        copyWith(),
        false,
      );
    } else {
      return Tuple2(
        copyWith(activeChatsIds: List.from(activeChatsIds)..add(chatId)),
        true,
      );
    }
  }

  Tuple2<UserChatInfoModel, bool> removeActiveChat(String chatId) {
    if (activeChatsIds.contains(chatId)) {
      return Tuple2(
        copyWith(activeChatsIds: List.from(activeChatsIds)..remove(chatId)),
        true,
      );
    } else {
      return Tuple2(
        this,
        false,
      );
    }
  }

  UserChatInfoModel setOnlineStatus(bool status) {
    if (status) {
      return copyWith(
        isOnline: status,
        lastSeen: DateTime.now(),
      );
    } else {
      return copyWith(isOnline: status);
    }
  }

  NetworkImage? getProfilePicture() =>
      profilePictureUrl != null ? NetworkImage(profilePictureUrl!) : null;
}
