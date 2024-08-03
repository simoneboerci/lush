// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoUserInfoModelField {
  userId,
  username,
}

@immutable
class VideoUserInfoModel extends Equatable
    implements BaseModel<VideoUserInfoModel> {
  final String userId;
  final String username;

  const VideoUserInfoModel({
    required this.userId,
    required this.username,
  });

  factory VideoUserInfoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoUserInfoModel(
        userId: map[VideoUserInfoModelField.userId.name] as String? ?? '',
        username: map[VideoUserInfoModelField.username.name] as String? ?? '',
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoUserInfoModelField.userId.name: userId,
      VideoUserInfoModelField.username.name: username,
    };
  }

  @override
  VideoUserInfoModel copyWith({
    String? userId,
    String? username,
  }) {
    return VideoUserInfoModel(
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
