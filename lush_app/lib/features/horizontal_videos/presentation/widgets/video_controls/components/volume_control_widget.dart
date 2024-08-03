import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/video_control_component_widget.dart';
import 'package:video_player/video_player.dart';

class VolumeControlWidget extends VideoControlComponentWidget {
  final IconData volumeOffIcon;
  final IconData volumeUpIcon;
  final Color volumeOffIconColor;
  final Color volumeUpIconColor;

  const VolumeControlWidget({
    super.key,
    required super.controller,
    super.hideOnPlay = false,
    super.hideOnPreview = false,
    super.hideOnPause = false,
    this.volumeOffIcon = Icons.volume_off,
    this.volumeUpIcon = Icons.volume_up,
    this.volumeOffIconColor = Colors.white,
    this.volumeUpIconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (hideOnPlay && value.isPlaying) return const SizedBox.shrink();
        if (hideOnPause && !value.isPlaying) return const SizedBox.shrink();

        return Row(
          children: [
            IconButton(
              onPressed: () {
                controller.setVolume(value.volume == 0 ? 1.0 : 0.0);
              },
              icon: Icon(
                value.volume == 0 ? volumeOffIcon : volumeUpIcon,
                color:
                    value.volume == 0 ? volumeOffIconColor : volumeUpIconColor,
              ),
            ),
            Slider(
              value: value.volume,
              onChanged: (newVolume) {
                controller.setVolume(newVolume);
              },
              min: 0.0,
              max: 1.0,
            ),
          ],
        );
      },
    );
  }
}
