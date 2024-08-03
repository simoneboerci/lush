import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

abstract class VideoControlComponentWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final bool hideOnPreview;
  final bool hideOnPlay;
  final bool hideOnPause;
  const VideoControlComponentWidget({
    super.key,
    required this.controller,
    required this.hideOnPreview,
    required this.hideOnPlay,
    required this.hideOnPause,
  });
}
