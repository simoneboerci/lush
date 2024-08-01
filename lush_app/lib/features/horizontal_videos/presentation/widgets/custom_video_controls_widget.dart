import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onPause;

  const CustomVideoControlsWidget({
    super.key,
    required this.controller,
    required this.onPause,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Progress bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black54,
            ),
          ),
        ),
        // Control buttons
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                    onPause();
                  } else {
                    controller.play();
                  }
                },
              ),
              // Add more custom controls here as needed
            ],
          ),
        ),
        // Fullscreen button
        Positioned(
          right: 8,
          bottom: 8,
          child: IconButton(
            icon: const Icon(Icons.fullscreen, color: Colors.white),
            onPressed: () {
              // TODO: Implement fullscreen functionality
            },
          ),
        ),
      ],
    );
  }
}
