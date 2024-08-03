// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class VideoUserInfo extends Equatable {
  final String userId;
  final String username;

  const VideoUserInfo({
    required this.userId,
    required this.username,
  });

  VideoUserInfo copyWith({
    String? userId,
    String? username,
  }) {
    return VideoUserInfo(
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        username,
      ];
}
