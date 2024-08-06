// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoUserInfoModelField {
  userId,
}

@immutable
class HorizontalVideoUserInfoModel extends Equatable
    implements BaseModel<HorizontalVideoUserInfoModel> {
  final String userId;

  const HorizontalVideoUserInfoModel({
    required this.userId,
  });

  factory HorizontalVideoUserInfoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoUserInfoModel(
        userId:
            map[HorizontalVideoUserInfoModelField.userId.name] as String? ?? '',
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoUserInfoModelField.userId.name: userId,
    };
  }

  @override
  HorizontalVideoUserInfoModel copyWith({
    String? userId,
    String? username,
  }) {
    return HorizontalVideoUserInfoModel(
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        userId,
      ];
}
