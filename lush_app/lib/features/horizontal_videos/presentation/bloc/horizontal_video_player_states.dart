import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class HorizontalVideoPlayerState extends Equatable {
  const HorizontalVideoPlayerState();

  @override
  List<Object?> get props => [];
}

@immutable
final class HorizontalVideoPlayerInitialState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerInitialState();
}

@immutable
final class HorizontalVideoPlayerLoadingState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerLoadingState();
}

@immutable
final class HorizontalVideoPlayerLoadedState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerLoadedState();
}

@immutable
final class HorizontalVideoPlayerPlayingState
    extends HorizontalVideoPlayerState {
  final Duration currentPosition;

  const HorizontalVideoPlayerPlayingState(this.currentPosition);

  @override
  List<Object?> get props => [currentPosition];
}

@immutable
final class HorizontalVideoPlayerPausedState
    extends HorizontalVideoPlayerState {
  final Duration currentPosition;

  const HorizontalVideoPlayerPausedState(this.currentPosition);

  @override
  List<Object?> get props => [currentPosition];
}

@immutable
final class HorizontalVideoPlayerStoppedState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerStoppedState();
}

@immutable
final class HorizontalVideoPlayerBufferingState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerBufferingState();
}

@immutable
final class HorizontalVideoPlayerErrorState extends HorizontalVideoPlayerState {
  final String message;

  const HorizontalVideoPlayerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

@immutable
final class HorizontalVideoPlayerSeekState extends HorizontalVideoPlayerState {
  final Duration targetPosition;

  const HorizontalVideoPlayerSeekState(this.targetPosition);

  @override
  List<Object?> get props => [targetPosition];
}

@immutable
final class HorizontalVideoPlayerVolumeChangedState
    extends HorizontalVideoPlayerState {
  final double volume;

  const HorizontalVideoPlayerVolumeChangedState(this.volume);

  @override
  List<Object?> get props => [volume];
}

final class HorizontalVideoPlayerMuteToggledState
    extends HorizontalVideoPlayerState {
  final bool isMute;

  const HorizontalVideoPlayerMuteToggledState(this.isMute);

  @override
  List<Object?> get props => [isMute];
}

@immutable
final class HorizontalVideoPlayerFullscreenToggledState
    extends HorizontalVideoPlayerState {
  final bool isFullscreen;

  const HorizontalVideoPlayerFullscreenToggledState(this.isFullscreen);

  @override
  List<Object?> get props => [isFullscreen];
}

@immutable
final class HorizontalVideoPlayerPlaybackCompletedState
    extends HorizontalVideoPlayerState {
  const HorizontalVideoPlayerPlaybackCompletedState();
}
