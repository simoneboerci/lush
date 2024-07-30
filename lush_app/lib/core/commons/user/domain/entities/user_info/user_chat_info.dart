import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

@immutable
class UserChatInfo extends Equatable {
  final String? username;
  final String? profilePictureUrl;
  final DateTime lastSeen;
  final List<String> activeChatsIds;
  final bool isOnline;

  const UserChatInfo({
    this.username,
    this.profilePictureUrl,
    required this.lastSeen,
    this.activeChatsIds = const [],
    required this.isOnline,
  });

  UserChatInfo copyWith({
    String? username,
    String? profilePictureUrl,
    DateTime? lastSeen,
    List<String>? activeChatsIds,
    bool? isOnline,
  }) {
    return UserChatInfo(
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      lastSeen: lastSeen ?? this.lastSeen,
      activeChatsIds: activeChatsIds ?? this.activeChatsIds,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props =>
      [username, profilePictureUrl, lastSeen, activeChatsIds, isOnline];
}
