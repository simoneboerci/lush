import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_advanced_stats.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_details.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_metadata.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_state.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_user_info.dart';
import 'package:lush_app/core/commons/video/domain/entities/video_user_interactions.dart';

@immutable
class Video extends Equatable {
  final String id;
  final VideoUserInfo userInfo;
  final VideoDetails details;
  final VideoMetadata metadata;
  final VideoState state;
  final VideoAdvancedStats advancedStats;
  final VideoUserInteractions userInteractions;

  const Video({
    required this.id,
    required this.userInfo,
    required this.details,
    required this.metadata,
    required this.state,
    required this.advancedStats,
    required this.userInteractions,
  });

  @override
  List<Object?> get props => [
        id,
        userInfo,
        details,
        metadata,
        state,
        advancedStats,
        userInteractions,
      ];
}
