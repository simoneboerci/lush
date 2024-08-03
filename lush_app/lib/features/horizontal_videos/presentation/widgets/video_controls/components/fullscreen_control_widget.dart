import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/video_control_component_widget.dart';
import 'package:video_player/video_player.dart';

class FullscreenControlWidget extends VideoControlComponentWidget {
  final VoidCallback onToggleFullscreen;
  final IconData fullscreenIcon;
  final Color fullscreenIconColor;

  const FullscreenControlWidget({
    super.key,
    required super.controller,
    super.hideOnPlay = false,
    super.hideOnPreview = true,
    super.hideOnPause = false,
    required this.onToggleFullscreen,
    this.fullscreenIcon = Icons.fullscreen,
    this.fullscreenIconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (hideOnPlay && value.isPlaying) return const SizedBox.shrink();
        if (hideOnPause && !value.isPlaying) return const SizedBox.shrink();

        return IconButton(
          onPressed: onToggleFullscreen,
          icon: Icon(
            fullscreenIcon,
            color: fullscreenIconColor,
          ),
        );
      },
    );
  }
}
