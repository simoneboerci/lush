import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/horizontal_videos/domain/interfaces/video_player_interface.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_player_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_player_states.dart';

class HorizontalVideoPlayerBloc
    extends Bloc<HorizontalVideoPlayerEvent, HorizontalVideoPlayerState> {
  final VideoPlayerInterface _videoPlayerInterface;

  HorizontalVideoPlayerBloc({
    required VideoPlayerInterface videoPlayerInterface,
  })  : _videoPlayerInterface = videoPlayerInterface,
        super(const HorizontalVideoPlayerInitialState()) {
    on<HorizontalVideoPlayerLoadEvent>(_onHorizontalVideoPlayerLoad);
    on<HorizontalVideoPlayerPlayEvent>(_onHorizontalVideoPlayerPlay);
    on<HorizontalVideoPlayerPauseEvent>(_onHorizontalVideoPlayerPause);
    on<HorizontalVideoPlayerStopEvent>(_onHorizontalVideoPlayerStop);
    on<HorizontalVideoPlayerSeekEvent>(_onHorizontalVideoPlayerSeek);
    on<HorizontalVideoPlayerIncreaseVolumeEvent>(
        _onHorizontalVideoPlayerIncreaseVolume);
    on<HorizontalVideoPlayerDecreaseVolumeEvent>(
        _onHorizontalVideoPlayerDecreaseVolume);
    on<HorizontaLVideoPlayerToggleMuteEvent>(
        _onHorizontalVideoPlayerToggleMute);
    on<HorizontalVideoPlayerToggleFullscreenEvent>(
        _onHorizontalVideoPlayerToggleFullscreen);
  }

  Future<void> _onHorizontalVideoPlayerLoad(
      HorizontalVideoPlayerLoadEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    emit(const HorizontalVideoPlayerLoadingState());
    await _videoPlayerInterface.initialize();
    emit(const HorizontalVideoPlayerLoadedState());
  }

  Future<void> _onHorizontalVideoPlayerPlay(
      HorizontalVideoPlayerPlayEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.play();
    emit(HorizontalVideoPlayerPlayingState(
        _videoPlayerInterface.currentPosition));
  }

  Future<void> _onHorizontalVideoPlayerPause(
      HorizontalVideoPlayerPauseEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.pause();
    emit(HorizontalVideoPlayerPausedState(
        _videoPlayerInterface.currentPosition));
  }

  Future<void> _onHorizontalVideoPlayerStop(
      HorizontalVideoPlayerStopEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.stop();
    emit(const HorizontalVideoPlayerStoppedState());
  }

  Future<void> _onHorizontalVideoPlayerSeek(
      HorizontalVideoPlayerSeekEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.seek(event.targetPosition);
    emit(HorizontalVideoPlayerSeekState(event.targetPosition));
  }

  Future<void> _onHorizontalVideoPlayerIncreaseVolume(
      HorizontalVideoPlayerIncreaseVolumeEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.increaseVolume(event.volume);
    emit(HorizontalVideoPlayerVolumeChangedState(event.volume));
  }

  Future<void> _onHorizontalVideoPlayerDecreaseVolume(
      HorizontalVideoPlayerDecreaseVolumeEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.decreaseVolume(event.volume);
    emit(HorizontalVideoPlayerVolumeChangedState(event.volume));
  }

  Future<void> _onHorizontalVideoPlayerToggleMute(
      HorizontaLVideoPlayerToggleMuteEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.toggleMute();
    emit(HorizontalVideoPlayerMuteToggledState(_videoPlayerInterface.isMute));
  }

  Future<void> _onHorizontalVideoPlayerToggleFullscreen(
      HorizontalVideoPlayerToggleFullscreenEvent event,
      Emitter<HorizontalVideoPlayerState> emit) async {
    await _videoPlayerInterface.toggleFullscreen();
    emit(HorizontalVideoPlayerFullscreenToggledState(
        _videoPlayerInterface.isFullscreen));
  }
}
