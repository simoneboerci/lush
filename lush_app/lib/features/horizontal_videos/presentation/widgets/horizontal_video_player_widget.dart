import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/custom_video_controls_widget.dart';
import 'package:video_player/video_player.dart';

class HorizontalVideoPlayerWidget extends StatefulWidget {
  final HorizontalVideo video;
  final bool allowPreview;

  const HorizontalVideoPlayerWidget({
    super.key,
    required this.video,
    this.allowPreview = false,
  });

  @override
  State<HorizontalVideoPlayerWidget> createState() =>
      _HorizontalVideoPlayerWidgetState();
}

class _HorizontalVideoPlayerWidgetState
    extends State<HorizontalVideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    _initializePlayer();
    super.initState();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.url));

    try {
      await _videoPlayerController.initialize();
      await _videoPlayerController.play();
      _isPlaying = true;
      setState(() {});
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.video.thumbnaillUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey);
              },
            ),
            if (_videoPlayerController.value.isInitialized)
              VideoPlayer(
                _videoPlayerController,
              ),
            if (!_isPlaying)
              Center(
                child: IconButton(
                  icon: const Icon(Icons.play_circle_filled),
                  iconSize: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isPlaying = true;
                      _videoPlayerController.play();
                    });
                  },
                ),
              ),
            if (_isPlaying)
              CustomVideoControlsWidget(
                controller: _videoPlayerController,
                onPause: () => setState(() => _isPlaying = false),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
