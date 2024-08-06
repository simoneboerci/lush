// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_advanced_stats.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_details.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_file_info.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_metadata.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_state.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_info.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video_user_interactions.dart';

@immutable
class HorizontalVideo extends Equatable {
  final String id;
  final HorizontalVideoUserInfo userInfo;
  final HorizontalVideoDetails details;
  final HorizontalVideoFileInfo fileInfo;
  final HorizontalVideoMetadata metadata;
  final HorizontalVideoState state;
  final HorizontalVideoAdvancedStats advancedStats;
  final HorizontalVideoUserInteractions userInteractions;

  const HorizontalVideo({
    required this.id,
    required this.userInfo,
    required this.details,
    required this.fileInfo,
    required this.metadata,
    required this.state,
    required this.advancedStats,
    required this.userInteractions,
  });

  HorizontalVideo copyWith({
    String? id,
    HorizontalVideoUserInfo? userInfo,
    HorizontalVideoDetails? details,
    HorizontalVideoFileInfo? fileInfo,
    HorizontalVideoMetadata? metadata,
    HorizontalVideoState? state,
    HorizontalVideoAdvancedStats? advancedStats,
    HorizontalVideoUserInteractions? userInteractions,
  }) {
    return HorizontalVideo(
      id: id ?? this.id,
      userInfo: userInfo ?? this.userInfo,
      details: details ?? this.details,
      fileInfo: fileInfo ?? this.fileInfo,
      metadata: metadata ?? this.metadata,
      state: state ?? this.state,
      advancedStats: advancedStats ?? this.advancedStats,
      userInteractions: userInteractions ?? this.userInteractions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userInfo,
        details,
        fileInfo,
        metadata,
        state,
        advancedStats,
        userInteractions,
      ];
}
