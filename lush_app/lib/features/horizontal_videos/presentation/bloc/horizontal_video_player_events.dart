import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class HorizontalVideoPlayerEvent extends Equatable {
  const HorizontalVideoPlayerEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class HorizontalVideoPlayerLoadEvent extends HorizontalVideoPlayerEvent {
  const HorizontalVideoPlayerLoadEvent();
}

@immutable
final class HorizontalVideoPlayerPlayEvent extends HorizontalVideoPlayerEvent {
  const HorizontalVideoPlayerPlayEvent();
}

@immutable
final class HorizontalVideoPlayerPauseEvent extends HorizontalVideoPlayerEvent {
  const HorizontalVideoPlayerPauseEvent();
}

@immutable
final class HorizontalVideoPlayerStopEvent extends HorizontalVideoPlayerEvent {
  const HorizontalVideoPlayerStopEvent();
}

@immutable
final class HorizontalVideoPlayerSeekEvent extends HorizontalVideoPlayerEvent {
  final Duration targetPosition;

  const HorizontalVideoPlayerSeekEvent(this.targetPosition);

  @override
  List<Object?> get props => [targetPosition];
}

@immutable
final class HorizontalVideoPlayerIncreaseVolumeEvent
    extends HorizontalVideoPlayerEvent {
  final double volume;

  const HorizontalVideoPlayerIncreaseVolumeEvent(this.volume);

  @override
  List<Object?> get props => [volume];
}

@immutable
final class HorizontalVideoPlayerDecreaseVolumeEvent
    extends HorizontalVideoPlayerEvent {
  final double volume;

  const HorizontalVideoPlayerDecreaseVolumeEvent(this.volume);

  @override
  List<Object?> get props => [volume];
}

@immutable
final class HorizontaLVideoPlayerToggleMuteEvent
    extends HorizontalVideoPlayerEvent {
  final bool isMute;

  const HorizontaLVideoPlayerToggleMuteEvent(this.isMute);

  @override
  List<Object?> get props => [isMute];
}

@immutable
final class HorizontalVideoPlayerToggleFullscreenEvent
    extends HorizontalVideoPlayerEvent {
  final bool isFullscreen;

  const HorizontalVideoPlayerToggleFullscreenEvent(this.isFullscreen);

  @override
  List<Object?> get props => [isFullscreen];
}
