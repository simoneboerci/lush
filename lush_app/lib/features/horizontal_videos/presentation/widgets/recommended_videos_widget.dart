import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/viewmodels/flexible_video_player_view_model.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/flexible_video_player.dart';

class HorizontalRecommendedVideosWidget extends StatefulWidget {
  final HorizontalVideo currentVideo;

  const HorizontalRecommendedVideosWidget({
    super.key,
    required this.currentVideo,
  });

  @override
  HorizontalRecommendedVideosWidgetState createState() =>
      HorizontalRecommendedVideosWidgetState();
}

class HorizontalRecommendedVideosWidgetState
    extends State<HorizontalRecommendedVideosWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HorizontalVideoBloc>().add(const GetHorizontalVideosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: CustomText(
            text: 'Recommended Videos',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocConsumer<HorizontalVideoBloc, HorizontalVideoState>(
          listener: (context, state) {
            if (state is HorizontalVideoErrorState) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is HorizontalVideosLoadingState) {
              return const CustomLoader();
            } else if (state is HorizontalVideosLoadedState) {
              final List<HorizontalVideo> recommendedVideos = state
                  .horizontalVideos
                  .where((video) => video.id != widget.currentVideo.id)
                  .toList();

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedVideos.length,
                  itemBuilder: (context, index) {
                    final video = recommendedVideos[index];
                    return _buildVideoItem(video, index);
                  },
                ),
              );
            }
            return const Center(
              child:
                  Text('An error occurred while fetching recommended videos'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVideoItem(HorizontalVideo video, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: index == 1 ? 0 : 20,
      ),
      width: index == 1 ? 200 : 150,
      child: FlexibleVideoPlayer(
        videwModel: FlexibleVideoPlayerViewModel(
          videoUrl: video.url,
          thumnailUrl: video.thumbnaillUrl,
          onTap: () => _onVideoTap(video),
        ),
      ),
    );
  }

  void _onVideoTap(HorizontalVideo video) {
    context
        .read<HorizontalVideoBloc>()
        .add(GetHorizontalVideoByIdEvent(video.id));
    // Navigate to video player screen or update current video
  }
}
