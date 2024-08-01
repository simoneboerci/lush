import 'package:equatable/equatable.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';

abstract interface class HorizontalVideoState extends Equatable {
  const HorizontalVideoState();

  @override
  List<Object?> get props => [];
}

final class HorizontalVideoInitalState extends HorizontalVideoState {
  const HorizontalVideoInitalState();
}

final class HorizontalVideosLoadingState extends HorizontalVideoState {
  const HorizontalVideosLoadingState();
}

final class HorizontalVideosLoadedState extends HorizontalVideoState {
  final List<HorizontalVideo> horizontalVideos;

  const HorizontalVideosLoadedState(this.horizontalVideos);

  @override
  List<Object?> get props => [horizontalVideos];
}

final class HorizontalVideoLoadingState extends HorizontalVideoState {
  const HorizontalVideoLoadingState();
}

final class HorizontalVideoLoadedState extends HorizontalVideoState {
  final HorizontalVideo horizontalVideo;

  const HorizontalVideoLoadedState(this.horizontalVideo);

  @override
  List<Object?> get props => [horizontalVideo];
}

final class HorizontalVideoUploadingState extends HorizontalVideoState {
  const HorizontalVideoUploadingState();
}

final class HorizontalVideoUploadedState extends HorizontalVideoState {
  final HorizontalVideo horizontalVideo;

  const HorizontalVideoUploadedState(this.horizontalVideo);

  @override
  List<Object?> get props => [horizontalVideo];
}

final class HorizontalVideoErrorState extends HorizontalVideoState {
  final String message;

  const HorizontalVideoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
