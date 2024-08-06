// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideoDetails extends Equatable {
  final String title;
  final String description;
  final List<String> tags;
  final String category;
  final String privacy;

  const HorizontalVideoDetails({
    required this.title,
    this.description = '',
    this.tags = const [],
    this.category = '',
    this.privacy = '',
  });

  HorizontalVideoDetails copyWith({
    String? title,
    String? description,
    List<String>? tags,
    String? category,
    String? privacy,
  }) {
    return HorizontalVideoDetails(
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
