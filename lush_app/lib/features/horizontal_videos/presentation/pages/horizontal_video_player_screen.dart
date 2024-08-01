import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_bloc.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';

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
            return Container();
          }

          return const Center(child: Text('An unexpected error occurred'));
        },
      ),
    );
  }
}
