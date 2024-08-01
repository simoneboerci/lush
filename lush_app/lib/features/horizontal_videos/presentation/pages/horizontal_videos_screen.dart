import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/horizontal_video_list_item_widget.dart';

class HorizontalVideosScreen extends StatefulWidget {
  const HorizontalVideosScreen({super.key});

  @override
  HorizontalVideosScreenState createState() => HorizontalVideosScreenState();
}

class HorizontalVideosScreenState extends State<HorizontalVideosScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<HorizontalVideoBloc>().add(const GetHorizontalVideosEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
                          return HorizontalVideoListItemWidget(
                            video: videos[index],
                          );
                        }),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
