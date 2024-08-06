import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_list_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_list_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_list_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/custom_video_player.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/title_video_card_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/minimal_video_controls_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_player_widget.dart';

class HorizontalVideoListScreen extends StatefulWidget {
  const HorizontalVideoListScreen({super.key});

  @override
  State<HorizontalVideoListScreen> createState() =>
      _HorizontalVideoListScreenState();
}

class _HorizontalVideoListScreenState extends State<HorizontalVideoListScreen> {
  final ScrollController _scrollController = ScrollController();

  final Map<String, CustomVideoPlayer> _videoPlayers = {};

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // TODO: Carica altri video
    }
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<HorizontalVideoListBloc>()
        .add(const HorizontalVideoListFetchVideosEvent());
    return CustomBackground(
      child: Column(
        children: [
          const CustomAppBarWidget(
            title: 'Videos',
            showTokensCount: true,
          ),
          Flexible(
            child:
                BlocConsumer<HorizontalVideoListBloc, HorizontalVideoListState>(
              listener: (context, state) {
                if (state is HorizontalVideoListErrorState) {
                  showSnackBar(context, state.message);
                } else if (state is HorizontalVideoListPaginationErrorState) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                print(state);
                if (state is HorizontalVideoListLoadingState ||
                    state is HorizontalVideoListPaginationLoadingState) {
                  return const CustomLoader();
                } else if (state is HorizontalVideoListLoadedState) {
                  _buildVideoListWidget(state.videos);
                } else if (state is HorizontalVideoListPaginationLoadedState) {
                  _buildVideoListWidget(state.additionalVideos);
                }

                return const Center(child: Text('An unkown error occured'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoListWidget(List<HorizontalVideo> videos) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          if (index == videos.length) {
            return const CustomLoader();
          }

          final currentVideo = videos[index];

          final videoPlayer = _videoPlayers.putIfAbsent(
              currentVideo.id, () => _createVideoPlayer(currentVideo));

          return VideoPlayerWidget(videoPlayer: videoPlayer);
        },
      ),
    );
  }

  CustomVideoPlayer _createVideoPlayer(HorizontalVideo video) {
    return CustomVideoPlayer(
      videoUrl: video.fileInfo.videoUrl,
      thumbnailUrl: video.fileInfo.thumbnailUrl,
      enablePreview: true,
      onTap: () {
        //TODO: Go to video details screen
      },
      controlsBuilder: (context, videoPlayer) {
        return MinimalVideoControlsWidget(
          controller: videoPlayer.controller,
          onPressed: () {
            // TODO: Go to video details screen
          },
        );
      },
      additionalComponents: (_, __) {
        return TitleVideoCardWidget(title: video.details.title);
      },
    );
  }

  @override
  void dispose() async {
    _scrollController.dispose();
    for (final videoPlayer in _videoPlayers.values) {
      await videoPlayer.dispose();
    }
    super.dispose();
  }
}
