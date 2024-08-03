import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/features/horizontal_videos/presentation/widgets/video_cards/video_card_widget.dart';

class TitleVideoCardWidget extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  final FontWeight titleFontWeight;

  const TitleVideoCardWidget({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.titleFontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return VideoCardWidget(
      child: CustomText(
        margin: padding,
        text: title,
        fontWeight: titleFontWeight,
      ),
    );
  }
}
