import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/video_control_component_widget.dart';
import 'package:video_player/video_player.dart';

class PlayPauseVideoControlWidget extends VideoControlComponentWidget {
  final VoidCallback onPlayPause;
  final IconData playIcon;
  final IconData pauseIcon;
  final Color playIconColor;
  final Color pauseIconColor;
  final Color playIconBackgroundColor;
  final Color pauseIconBackgroundColor;

  const PlayPauseVideoControlWidget({
    super.key,
    required super.controller,
    super.hideOnPlay = true,
    super.hideOnPreview = true,
    super.hideOnPause = false,
    required this.onPlayPause,
    this.playIcon = Icons.play_arrow_rounded,
    this.pauseIcon = Icons.pause_rounded,
    this.playIconColor = Colors.white,
    this.pauseIconColor = Colors.white,
    this.playIconBackgroundColor = Colors.black45,
    this.pauseIconBackgroundColor = Colors.black45,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (hideOnPlay && value.isPlaying) return const SizedBox.shrink();
        if (hideOnPause && !value.isPlaying) return const SizedBox.shrink();

        return CustomIconButton(
          onPressed: onPlayPause,
          backgroundColor: value.isPlaying
              ? pauseIconBackgroundColor
              : playIconBackgroundColor,
          icon: value.isPlaying ? pauseIcon : playIcon,
          iconColor: value.isPlaying ? pauseIconColor : playIconColor,
        );
      },
    );
  }
}
