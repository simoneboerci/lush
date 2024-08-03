import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/components/video_control_component_widget.dart';
import 'package:video_player/video_player.dart';

class VideoDurationControlWidget extends VideoControlComponentWidget {
  const VideoDurationControlWidget({
    super.key,
    required super.controller,
    super.hideOnPreview = true,
    super.hideOnPlay = false,
    super.hideOnPause = false,
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
              CustomText(
                margin: EdgeInsets.zero,
                text: _formatDuration(value.position),
                fontWeight: FontWeight.bold,
              ),
              const CustomText(text: '/'),
              CustomText(
                margin: EdgeInsets.zero,
                text: _formatDuration(value.duration),
              ),
            ],
          );
        });
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${_formatDaysFromDuration(duration)}:${_formatHoursFromDuration(duration)}:${_formatMinutesFromDuration(duration)}:${_getSecondsFromDuration(duration)}';
    }

    if (duration.inHours > 0) {
      return '${_formatHoursFromDuration(duration)}:${_formatMinutesFromDuration(duration)}:${_getSecondsFromDuration(duration)}';
    }

    return '${_formatMinutesFromDuration(duration)}:${_getSecondsFromDuration(duration)}';
  }

  String _formatDaysFromDuration(Duration duration) {
    return duration.inDays.toString().padLeft(2, '0');
  }

  String _formatHoursFromDuration(Duration duration) {
    return duration.inHours.remainder(24).abs().toString().padLeft(2, '0');
  }

  String _formatMinutesFromDuration(Duration duration) {
    return duration.inMinutes.remainder(60).abs().toString().padLeft(2, '0');
  }

  String _getSecondsFromDuration(Duration duration) {
    return duration.inSeconds.remainder(60).abs().toString().padLeft(2, '0');
  }
}
