import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/horizontal_video_player_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/recommended_videos_widget.dart';

class HorizontalVideoPlayerScreen extends StatelessWidget {
  const HorizontalVideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: BlocConsumer<HorizontalVideoBloc, HorizontalVideoState>(
        listener: (context, state) {
          if (state is HorizontalVideoErrorState) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is HorizontalVideoLoadingState) {
            return const CustomLoader();
          } else if (state is HorizontalVideoLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomAppBarWidget(
                    title: 'Videos', showTokensCount: true),
                HorizontalVideoPlayerWidget(
                  video: state.horizontalVideo,
                  allowPreview: false,
                ),
                HorizontalRecommendedVideosWidget(video: state.horizontalVideo),
              ],
            );
          }

          return const Center(child: Text('An unexpected error occurred'));
        },
      ),
    );
  }
}
