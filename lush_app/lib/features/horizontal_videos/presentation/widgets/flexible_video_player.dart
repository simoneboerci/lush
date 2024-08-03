import 'package:flutter/material.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/viewmodels/flexible_video_player_view_model.dart';
import 'package:video_player/video_player.dart';

class FlexibleVideoPlayer extends StatefulWidget {
  final FlexibleVideoPlayerViewModel videwModel;
  final double borderRadius;
  final double aspectRatio;

  const FlexibleVideoPlayer({
    super.key,
    required this.videwModel,
    this.borderRadius = 8.0,
    this.aspectRatio = 16 / 9,
  });

  @override
  State<FlexibleVideoPlayer> createState() => _FlexibleVideoPlayerState();
}

class _FlexibleVideoPlayerState extends State<FlexibleVideoPlayer> {
  @override
  void initState() {
    super.initState();
    widget.videwModel.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.videwModel.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.videwModel.onTap ?? widget.videwModel.togglePlayPause,
          onLongPress: widget.videwModel.onLongPress ??
              (widget.videwModel.enablePreview == true
                  ? widget.videwModel.startPreview
                  : null),
          onLongPressEnd: widget.videwModel.onLongPressEnd ??
              (widget.videwModel.enablePreview == true
                  ? (_) => widget.videwModel.stopPreview()
                  : null),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.videwModel.isInitialized &&
                      !widget.videwModel.isPlaying &&
                      !widget.videwModel.isPreviewActive &&
                      widget.videwModel.isAtTheBeginning)
                    Image.network(
                      widget.videwModel.thumnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        showSnackBar(context, error.toString());
                        return Container(color: Colors.grey);
                      },
                    ),
                  if (widget.videwModel.isInitialized &&
                      (widget.videwModel.isPlaying ||
                          widget.videwModel.isPreviewActive ||
                          !widget.videwModel.isAtTheBeginning))
                    VideoPlayer(widget.videwModel.controller),
                  if (widget.videwModel.controlsBuilder != null)
                    widget.videwModel.controlsBuilder!(
                        context, widget.videwModel),
                ],
              ),
            ),
          ),
        ),
        if (widget.videwModel.additionalComponents != null)
          widget.videwModel.additionalComponents!(context, widget.videwModel),
      ],
    );
  }
}
