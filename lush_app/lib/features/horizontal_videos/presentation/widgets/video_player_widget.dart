import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_player_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_player_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_player_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/custom_video_player.dart';
import 'package:lush_app/init_dependencies.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final CustomVideoPlayer videoPlayer;
  final double borderRadius;
  final double aspectRatio;

  const VideoPlayerWidget(
      {super.key,
      required this.videoPlayer,
      this.borderRadius = 8.0,
      this.aspectRatio = 16 / 9});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HorizontalVideoPlayerBloc(videoPlayerInterface: serviceLocator())
            ..add(const HorizontalVideoPlayerLoadEvent()),
      child:
          BlocConsumer<HorizontalVideoPlayerBloc, HorizontalVideoPlayerState>(
        listener: (context, state) {
          if (state is HorizontalVideoPlayerErrorState) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is HorizontalVideoPlayerLoadingState) {
            return const CustomLoader();
          } else if (state is HorizontalVideoPlayerLoadedState) {
            return Column(
              children: [
                GestureDetector(
                  onTap: videoPlayer.onTap ?? videoPlayer.togglePlayPause,
                  onLongPress: videoPlayer.onLongPress ??
                      (videoPlayer.enablePreview == true
                          ? videoPlayer.startPreview
                          : null),
                  onLongPressEnd: videoPlayer.onLongPressEnd ??
                      (videoPlayer.enablePreview == true
                          ? (_) => videoPlayer.stopPreview()
                          : null),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (videoPlayer.isInitialized &&
                              !videoPlayer.isPlaying &
                                  !videoPlayer.isPreviewActive &&
                              videoPlayer.isAtTheBeginning)
                            Image.network(
                              videoPlayer.thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                showSnackBar(context, error.toString());
                                return Container(color: Colors.grey);
                              },
                            ),
                          if (videoPlayer.isInitialized &&
                              (videoPlayer.isPlaying ||
                                  videoPlayer.isPreviewActive ||
                                  !videoPlayer.isAtTheBeginning))
                            VideoPlayer(videoPlayer.controller),
                          if (videoPlayer.controlsBuilder != null)
                            videoPlayer.controlsBuilder!(context, videoPlayer),
                        ],
                      ),
                    ),
                  ),
                ),
                if (videoPlayer.additionalComponents != null)
                  videoPlayer.additionalComponents!(context, videoPlayer),
              ],
            );
          }

          return const Center(child: Text('An unknown error occurred'));
        },
      ),
    );
  }
}
