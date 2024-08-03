import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoModelField {
  id,
  url,
  thumbnailUrl,
  title,
}

@immutable
class HorizontalVideoModel extends Equatable
    implements BaseModel<HorizontalVideoModel> {
  final String id;
  final String url;
  final String thumbnailUrl;
  final String title;

  const HorizontalVideoModel({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.title,
  });

  factory HorizontalVideoModel.fromMap(Map<String, dynamic> map) {
    return HorizontalVideoModel(
      id: map[HorizontalVideoModelField.id.name] as String? ?? '',
      url: map[HorizontalVideoModelField.url.name] as String? ?? '',
      thumbnailUrl:
          map[HorizontalVideoModelField.thumbnailUrl.name] as String? ?? '',
      title: map[HorizontalVideoModelField.title.name] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoModelField.id.name: id,
      HorizontalVideoModelField.url.name: url,
      HorizontalVideoModelField.thumbnailUrl.name: thumbnailUrl,
      HorizontalVideoModelField.title.name: title,
    };
  }

  @override
  HorizontalVideoModel copyWith(Map<String, dynamic> params) {
    return HorizontalVideoModel(
        id: params[HorizontalVideoModelField.id.name] as String? ?? id,
        url: params[HorizontalVideoModelField.url.name] as String? ?? url,
        thumbnailUrl:
            params[HorizontalVideoModelField.thumbnailUrl.name] as String? ??
                thumbnailUrl,
        title:
            params[HorizontalVideoModelField.title.name] as String? ?? title);
  }

  @override
  List<Object?> get props => [id, url, thumbnailUrl, title];
}
