// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoDetailsModelField {
  title,
  description,
  tags,
  category,
  privacy,
}

@immutable
class HorizontalVideoDetailsModel extends Equatable
    implements BaseModel<HorizontalVideoDetailsModel> {
  final String title;
  final String description;
  final List<String> tags;
  final String category;
  final String privacy;

  const HorizontalVideoDetailsModel({
    required this.title,
    this.description = '',
    this.tags = const [],
    this.category = '',
    this.privacy = '',
  });

  factory HorizontalVideoDetailsModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoDetailsModel(
        title:
            map[HorizontalVideoDetailsModelField.title.name] as String? ?? '',
        description:
            map[HorizontalVideoDetailsModelField.description.name] as String? ??
                '',
        tags:
            map[HorizontalVideoDetailsModelField.tags.name] as List<String>? ??
                [],
        category:
            map[HorizontalVideoDetailsModelField.category.name] as String? ??
                '',
        privacy:
            map[HorizontalVideoDetailsModelField.privacy.name] as String? ?? '',
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoDetailsModelField.title.name: title,
      HorizontalVideoDetailsModelField.description.name: description,
      HorizontalVideoDetailsModelField.tags.name: tags,
      HorizontalVideoDetailsModelField.category.name: category,
      HorizontalVideoDetailsModelField.privacy.name: privacy,
    };
  }

  @override
  HorizontalVideoDetailsModel copyWith({
    String? title,
    String? description,
    List<String>? tags,
    String? category,
    String? privacy,
  }) {
    return HorizontalVideoDetailsModel(
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
