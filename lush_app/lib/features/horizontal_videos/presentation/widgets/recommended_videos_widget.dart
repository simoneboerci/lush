import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/horizontal_video_player_widget.dart';

class HorizontalRecommendedVideosWidget extends StatelessWidget {
  final HorizontalVideo video;

  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final String sectionLabel;
  final double sectionLabelFontSize;
  final FontWeight sectionLabelFontWeight;
  final Axis listViewScrollAxis;

  const HorizontalRecommendedVideosWidget({
    super.key,
    required this.video,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.sectionLabel = 'Recommended Videos',
    this.sectionLabelFontSize = 18.0,
    this.sectionLabelFontWeight = FontWeight.bold,
    this.listViewScrollAxis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: padding,
          child: CustomText(
            text: sectionLabel,
            fontSize: sectionLabelFontSize,
            fontWeight: sectionLabelFontWeight,
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
              final List<HorizontalVideo> videos = state.horizontalVideos
                  .where((horizontalVideo) => horizontalVideo.id != video.id)
                  .toList();
              return ListView.builder(
                scrollDirection: listViewScrollAxis,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: index == 1 ? 0 : 20,
                    ),
                    width: index == 1 ? 200 : 150,
                    child: HorizontalVideoPlayerWidget(
                      video: videos[index],
                      allowPreview: true,
                    ),
                  );
                },
              );
            }
            return const Center(
                child: Text(
                    'An error occurred while getting horizontal videos from the database'));
          },
        ),
      ],
    );
  }
}
