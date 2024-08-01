import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/custom_video_controls_widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:math';

class HorizontalVideoListItemWidget extends StatefulWidget {
  final HorizontalVideo video;

  const HorizontalVideoListItemWidget({super.key, required this.video});

  @override
  State<HorizontalVideoListItemWidget> createState() =>
      _HorizontalVideoListItemWidgetState();
}

class _HorizontalVideoListItemWidgetState
    extends State<HorizontalVideoListItemWidget> {
  VideoPlayerController? _videoPlayerController;
  bool _isPreviewActive = false;
  bool _isPlaying = false;
  Timer? _previewTimer;
  final List<Duration> _previewSegments = [];
  final int _previewSegmentDuration = 3;
  final int _numberOfSegments = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer();
    });
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.url));
    try {
      await _videoPlayerController!.initialize();
      _generatePreviewSegments();
      if (mounted) setState(() {});
    } catch (e) {
      print("Error initializing video player: $e");
    }
  }

  void _generatePreviewSegments() {
    if (_videoPlayerController == null) return;

    final Random random = Random();
    final int videoDuration = _videoPlayerController!.value.duration.inSeconds;

    if (videoDuration > _previewSegmentDuration * _numberOfSegments) {
      for (int i = 0; i < _numberOfSegments; i++) {
        int startTime = random.nextInt(videoDuration - _previewSegmentDuration);
        _previewSegments.add(Duration(seconds: startTime));
      }
      _previewSegments.sort();
    } else {
      _previewSegments.clear();
      _previewSegments.add(Duration.zero);
    }
  }

  void _startPreview() {
    if (_videoPlayerController == null ||
        !_videoPlayerController!.value.isInitialized) return;

    setState(() => _isPreviewActive = true);
    _playNextPreviewSegment(0);
  }

  void _playNextPreviewSegment(int index) {
    if (!_isPreviewActive ||
        _videoPlayerController == null ||
        index >= _previewSegments.length) {
      _stopPreview();
      return;
    }

    _videoPlayerController!.seekTo(_previewSegments[index]);
    _videoPlayerController!.play();

    _previewTimer = Timer(Duration(seconds: _previewSegmentDuration), () {
      _playNextPreviewSegment(index + 1);
    });
  }

  void _stopPreview() {
    _previewTimer?.cancel();
    _previewTimer = null;
    if (mounted) {
      setState(() {
        _isPreviewActive = false;
        if (!_isPlaying && _videoPlayerController != null) {
          _videoPlayerController!.pause();
          _videoPlayerController!.seekTo(Duration.zero);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onLongPress: _startPreview,
        onLongPressEnd: (_) => _stopPreview(),
        onTap: () {
          if (_isPlaying) {
            setState(() => _isPlaying = false);
            _videoPlayerController?.pause();
          } else {
            context
                .read<HorizontalVideoBloc>()
                .add(GetHorizontalVideoByIdEvent(widget.video.id));
            Navigator.pushNamed(context, cHorizontalVideoPlayerScreen);
          }
        },
        child: Column(
          children: [
            AspectRatio(
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
                    if (_videoPlayerController?.value.isInitialized == true &&
                        (_isPreviewActive || _isPlaying))
                      VideoPlayer(_videoPlayerController!),
                    if (!_isPlaying && !_isPreviewActive)
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_filled,
                              size: 50, color: Colors.white),
                          onPressed: () {
                            if (_videoPlayerController?.value.isInitialized ==
                                true) {
                              setState(() {
                                _isPlaying = true;
                                _videoPlayerController!.play();
                              });
                            }
                          },
                        ),
                      ),
                    if (_isPlaying && _videoPlayerController != null)
                      CustomVideoControlsWidget(
                        controller: _videoPlayerController!,
                        onPause: () => setState(() => _isPlaying = false),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomText(
                text: widget.video.title,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
