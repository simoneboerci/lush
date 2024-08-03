// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoDetailsModelField {
  title,
  description,
  tags,
  category,
  privacy,
}

@immutable
class VideoDetailsModel extends Equatable
    implements BaseModel<VideoDetailsModel> {
  final String title;
  final String description;
  final List<String> tags;
  final String category;
  final String privacy;

  const VideoDetailsModel({
    required this.title,
    this.description = '',
    this.tags = const [],
    this.category = '',
    this.privacy = '',
  });

  factory VideoDetailsModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoDetailsModel(
        title: map[VideoDetailsModelField.title.name] as String? ?? '',
        description:
            map[VideoDetailsModelField.description.name] as String? ?? '',
        tags: map[VideoDetailsModelField.tags.name] as List<String>? ?? [],
        category: map[VideoDetailsModelField.category.name] as String? ?? '',
        privacy: map[VideoDetailsModelField.privacy.name] as String? ?? '',
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoDetailsModelField.title.name: title,
      VideoDetailsModelField.description.name: description,
      VideoDetailsModelField.tags.name: tags,
      VideoDetailsModelField.category.name: category,
      VideoDetailsModelField.privacy.name: privacy,
    };
  }

  @override
  VideoDetailsModel copyWith({
    String? title,
    String? description,
    List<String>? tags,
    String? category,
    String? privacy,
  }) {
    return VideoDetailsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      privacy: privacy ?? this.privacy,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        tags,
        category,
        privacy,
      ];
}
