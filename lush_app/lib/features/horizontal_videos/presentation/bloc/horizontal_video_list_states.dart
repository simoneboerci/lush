import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';

@immutable
abstract interface class HorizontalVideoListState extends Equatable {
  const HorizontalVideoListState();

  @override
  List<Object?> get props => [];
}

@immutable
class HorizontalVideoListInitialState extends HorizontalVideoListState {
  const HorizontalVideoListInitialState();
}

@immutable
class HorizontalVideoListLoadingState extends HorizontalVideoListState {
  const HorizontalVideoListLoadingState();
}

@immutable
class HorizontalVideoListLoadedState extends HorizontalVideoListState {
  final List<HorizontalVideo> videos;

  const HorizontalVideoListLoadedState(this.videos);

  @override
  List<Object?> get props => [videos];
}

@immutable
class HorizontalVideoListEmptyState extends HorizontalVideoListState {
  final DateTime lastCheck;

  const HorizontalVideoListEmptyState(this.lastCheck);

  @override
  List<Object?> get props => [lastCheck];
}

@immutable
class HorizontalVideoListErrorState extends HorizontalVideoListState {
  final String message;

  const HorizontalVideoListErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

@immutable
class HorizontalVideoListRefreshingState extends HorizontalVideoListState {
  const HorizontalVideoListRefreshingState();
}

@immutable
class HorizontalVideoListPaginationLoadingState
    extends HorizontalVideoListState {
  const HorizontalVideoListPaginationLoadingState();
}

@immutable
class HorizontalVideoListPaginationLoadedState
    extends HorizontalVideoListState {
  final List<HorizontalVideo> additionalVideos;

  const HorizontalVideoListPaginationLoadedState(this.additionalVideos);

  @override
  List<Object?> get props => [additionalVideos];
}

@immutable
class HorizontalVideoListPaginationErrorState extends HorizontalVideoListState {
  final String message;

  const HorizontalVideoListPaginationErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

@immutable
class HorizontalVideoListAddingItemState extends HorizontalVideoListState {
  const HorizontalVideoListAddingItemState();
}

@immutable
class HorizontalVideoListItemAddedState extends HorizontalVideoListState {
  final HorizontalVideo video;

  const HorizontalVideoListItemAddedState(this.video);

  @override
  List<Object?> get props => [video];
}

@immutable
class HorizontalVideoListGettingItemState extends HorizontalVideoListState {
  const HorizontalVideoListGettingItemState();
}

@immutable
class HorizontalVideoListItemGotState extends HorizontalVideoListState {
  final HorizontalVideo video;

  const HorizontalVideoListItemGotState(this.video);

  @override
  List<Object?> get props => [video];
}

@immutable
class HorizontalVideoListRemovingItemState extends HorizontalVideoListState {
  const HorizontalVideoListRemovingItemState();
}

@immutable
class HorizontalVideoListItemRemovedState extends HorizontalVideoListState {
  final HorizontalVideo video;

  const HorizontalVideoListItemRemovedState(this.video);

  @override
  List<Object?> get props => [video];
}

@immutable
class HorizontalVideoListUpdatingItemState extends HorizontalVideoListState {
  const HorizontalVideoListUpdatingItemState();
}

@immutable
class HorizontalVideoListItemUpdatedState extends HorizontalVideoListState {
  final HorizontalVideo video;

  const HorizontalVideoListItemUpdatedState(this.video);

  @override
  List<Object?> get props => [video];
}
