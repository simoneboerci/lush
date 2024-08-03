import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/viewmodels/flexible_video_player_view_model.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/flexible_video_player.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/recommended_videos_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/actions_video_card_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/title_video_card_widget.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_controls/basic_video_controls_widget.dart';

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
            final video = state.horizontalVideo;

            return Column(
              children: [
                const CustomAppBarWidget(
                  title: 'Videos',
                  showTokensCount: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FlexibleVideoPlayer(
                          videwModel: FlexibleVideoPlayerViewModel(
                            videoUrl: video.url,
                            thumnailUrl: video.thumbnaillUrl,
                            autoPlay: true,
                            enablePreview: false,
                            controlsBuilder: (_, viewModel) {
                              return BasicVideoControlsWidget(
                                controller: viewModel.controller,
                                togglePlayPause: viewModel.togglePlayPause,
                                toggleFullscreen: viewModel.toggleFullscreen,
                              );
                            },
                            additionalComponents: (_, __) {
                              return Column(
                                children: [
                                  TitleVideoCardWidget(title: video.title),
                                  ActionsVideoCardWidget(
                                    firstGroupButtons: [
                                      CustomIconButton(
                                        icon: Icons.heart_broken_outlined,
                                        onPressed: () {},
                                      ),
                                      CustomIconButton(
                                        icon: Icons.comment_outlined,
                                        onPressed: () {},
                                      ),
                                      CustomIconButton(
                                        icon: Icons.send_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                    secondGroupButtons: [
                                      CustomIconButton(
                                        icon: Icons.bookmark_outline,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        HorizontalRecommendedVideosWidget(
                          currentVideo: state.horizontalVideo,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('An unexpected error occurred'));
        },
      ),
    );
  }
}
