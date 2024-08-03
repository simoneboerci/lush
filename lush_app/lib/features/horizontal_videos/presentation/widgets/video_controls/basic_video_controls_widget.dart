import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/fullscreen_control_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/play_pause_video_control_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/progress_bar_control_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/video_duration_control_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/composite_video_controls_widget.dart';
import 'package:video_player/video_player.dart';

class BasicVideoControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback togglePlayPause;
  final Alignment iconButtonAlignment;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;
  final double iconSize;
  final Alignment progressBarAlignment;
  final VoidCallback toggleFullscreen;

  const BasicVideoControlsWidget({
    super.key,
    required this.controller,
    required this.togglePlayPause,
    this.iconButtonAlignment = Alignment.center,
    this.iconBackgroundColor = Colors.black45,
    this.iconColor = Colors.white,
    this.icon = Icons.play_arrow_rounded,
    this.iconSize = 30.0,
    this.progressBarAlignment = Alignment.bottomCenter,
    required this.toggleFullscreen,
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
            onPlayPause: togglePlayPause,
          ),
        ),
        Align(
          alignment: progressBarAlignment,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VideoDurationControlWidget(controller: controller),
                  FullscreenControlWidget(
                    controller: controller,
                    onToggleFullscreen: toggleFullscreen,
                  ),
                ],
              ),
              Flexible(child: ProgressBarControlWidget(controller: controller)),
            ],
          ),
        ),
      ],
    );
  }
}
