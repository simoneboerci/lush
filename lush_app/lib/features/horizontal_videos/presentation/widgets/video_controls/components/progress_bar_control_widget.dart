import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProgressBarControlWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final bool allowScrubbing;
  final Color playedColor;
  final Color bufferedColor;
  final Color backgroundColor;

  const ProgressBarControlWidget({
    super.key,
    required this.controller,
    this.allowScrubbing = true,
    this.playedColor = Colors.white,
    this.bufferedColor = Colors.grey,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: allowScrubbing,
      colors: VideoProgressColors(
        playedColor: playedColor,
        bufferedColor: bufferedColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
