import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';

@immutable
abstract interface class HorizontalVideoListEvent extends Equatable {
  const HorizontalVideoListEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class HorizontalVideoListGetAllVideosEvent
    extends HorizontalVideoListEvent {
  const HorizontalVideoListGetAllVideosEvent();
}

@immutable
final class HorizontalVideoListFetchVideosEvent
    extends HorizontalVideoListEvent {
  final String? lastDocumentId;
  final int pageSize;

  const HorizontalVideoListFetchVideosEvent({
    this.lastDocumentId,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [lastDocumentId, pageSize];
}

@immutable
final class HorizontalVideoListRefreshVideosEvent
    extends HorizontalVideoListEvent {
  const HorizontalVideoListRefreshVideosEvent();
}

@immutable
final class HorizontalVideoListGetVideoByIdEvent
    extends HorizontalVideoListEvent {
  final String id;

  const HorizontalVideoListGetVideoByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

@immutable
final class HorizontalVideoListUploadVideoEvent
    extends HorizontalVideoListEvent {
  final String userId;
  final File videoFile;
  final File thumbnailFile;
  final String title;
  final String description;
  final List<String> tags;
  final String category;
  final String privacy;
  final bool isLive;
  final bool isMonetized;

  const HorizontalVideoListUploadVideoEvent({
    required this.userId,
    required this.videoFile,
    required this.thumbnailFile,
    required this.title,
    this.description = '',
    this.tags = const [],
    this.category = '',
    this.privacy = '',
    required this.isLive,
    required this.isMonetized,
  });

  @override
  List<Object?> get props => [
        userId,
        videoFile,
        thumbnailFile,
        title,
        description,
        tags,
        category,
        privacy,
        isLive,
        isMonetized,
      ];
}

@immutable
final class HorizontalVideoListUpdateVideoEvent
    extends HorizontalVideoListEvent {
  final HorizontalVideo horizontalVideo;

  const HorizontalVideoListUpdateVideoEvent(this.horizontalVideo);

  @override
  List<Object?> get props => [horizontalVideo];
}

@immutable
final class HorizontalVideoListDeleteVideoEvent
    extends HorizontalVideoListEvent {
  final String id;

  const HorizontalVideoListDeleteVideoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

@immutable
final class HorizontalVideoListClearEvent extends HorizontalVideoListEvent {
  const HorizontalVideoListClearEvent();
}

@immutable
final class HorizontalVideoListFilterEvent extends HorizontalVideoListEvent {
  const HorizontalVideoListFilterEvent();
}

@immutable
final class HorizontalVideoListSortEvent extends HorizontalVideoListEvent {
  const HorizontalVideoListSortEvent();
}
