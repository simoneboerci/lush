import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/constants/routes.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/viewmodels/flexible_video_player_view_model.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/flexible_video_player.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/title_video_card_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/minimal_video_controls_widget.dart';

class HorizontalVideosScreen extends StatefulWidget {
  const HorizontalVideosScreen({super.key});

  @override
  HorizontalVideosScreenState createState() => HorizontalVideosScreenState();
}

class HorizontalVideosScreenState extends State<HorizontalVideosScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, FlexibleVideoPlayerViewModel> _videoViewModels = {};

  @override
  void initState() {
    context.read<HorizontalVideoBloc>().add(const GetHorizontalVideosEvent());
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HorizontalVideoBloc>().add(const GetHorizontalVideosEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        children: [
          const CustomAppBarWidget(title: 'Videos', showTokensCount: true),
          Flexible(
            child: BlocConsumer<HorizontalVideoBloc, HorizontalVideoState>(
              listener: (context, state) {
                if (state is HorizontalVideoErrorState) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is HorizontalVideosLoadingState) {
                  return const CustomLoader();
                } else if (state is HorizontalVideosLoadedState ||
                    state is HorizontalVideosLoadingMoreState) {
                  final videos = state is HorizontalVideosLoadedState
                      ? state.horizontalVideos
                      : (state as HorizontalVideosLoadingMoreState)
                          .loadedVideos;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: videos.length +
                          (state is HorizontalVideosLoadingMoreState ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == videos.length) {
                          return const CustomLoader();
                        }

                        final currentVideo = videos[index];
                        final viewModel = _videoViewModels.putIfAbsent(
                            currentVideo.id,
                            () => _createVideoPlayerViewModel(currentVideo));

                        return FlexibleVideoPlayer(videwModel: viewModel);
                      },
                    ),
                  );
                }
                return const Center(child: Text('Unknown error occurred'));
              },
            ),
          ),
        ],
      ),
    );
  }

  FlexibleVideoPlayerViewModel _createVideoPlayerViewModel(
      HorizontalVideo video) {
    return FlexibleVideoPlayerViewModel(
      videoUrl: video.url,
      thumnailUrl: video.thumbnaillUrl,
      enablePreview: true,
      onTap: () {
        context
            .read<HorizontalVideoBloc>()
            .add(GetHorizontalVideoByIdEvent(video.id));
        Navigator.pushNamed(context, cHorizontalVideoPlayerScreen);
      },
      controlsBuilder: (context, viewModel) {
        return MinimalVideoControlsWidget(
          controller: viewModel.controller,
          onPressed: () {
            context
                .read<HorizontalVideoBloc>()
                .add(GetHorizontalVideoByIdEvent(video.id));

            Navigator.pushNamed(context, cHorizontalVideoPlayerScreen);
          },
        );
      },
      additionalComponents: (_, __) {
        return TitleVideoCardWidget(title: video.title);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (final vm in _videoViewModels.values) {
      vm.dispose();
    }
    super.dispose();
  }
}
