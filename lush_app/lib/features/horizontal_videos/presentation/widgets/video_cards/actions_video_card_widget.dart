import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/video_card_widget.dart';

class ActionsVideoCardWidget extends StatelessWidget {
  final List<CustomIconButton> firstGroupButtons;
  final List<CustomIconButton> secondGroupButtons;

  const ActionsVideoCardWidget({
    super.key,
    required this.firstGroupButtons,
    required this.secondGroupButtons,
  });

  @override
  Widget build(BuildContext context) {
    return VideoCardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: firstGroupButtons,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: secondGroupButtons,
          ),
        ],
      ),
    );
  }
}
