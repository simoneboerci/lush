import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/play_pause_video_control_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/composite_video_controls_widget.dart';
import 'package:video_player/video_player.dart';

class MinimalVideoControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onPressed;
  final Alignment iconButtonAlignment;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;
  final double iconSize;

  const MinimalVideoControlsWidget({
    super.key,
    required this.controller,
    required this.onPressed,
    this.iconButtonAlignment = Alignment.center,
    this.iconBackgroundColor = Colors.black45,
    this.iconColor = Colors.white,
    this.icon = Icons.play_arrow_rounded,
    this.iconSize = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return CompositeVideoControlsWidget(
      controller: controller,
      components: [
        Align(
          alignment: iconButtonAlignment,
          child: PlayPauseVideoControlWidget(
            controller: controller,
            onPlayPause: onPressed,
          ),
        ),
      ],
    );
  }
}
