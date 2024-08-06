abstract interface class VideoPlayerInterface {
  bool get isInitialized;

  bool get isPlaying;
  bool get isPreviewActive;

  bool get isAtTheBeginning;

  bool get isFullscreen;
  bool get isMute;

  Duration get videoDuration;
  Duration get currentPosition;

  double get aspectRatio;

  Future<void> initialize();

  Future<void> play();
  Future<void> pause();
  Future<void> togglePlayPause();

  Future<void> startPreview();
  Future<void> stopPreview();

  Future<void> enableFullscreen();
  Future<void> disableFullscreen();
  Future<void> toggleFullscreen();

  Future<void> increaseVolume(double volume);
  Future<void> decreaseVolume(double volume);

  Future<void> mute();
  Future<void> unmute();
  Future<void> toggleMute();

  Future<void> seek(Duration position);
  Future<void> resetPlayer();
  Future<void> stop();

  Future<void> dispose();
}
