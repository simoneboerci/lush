import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class CollectionCardHashtagsWidget extends StatelessWidget {
  final List<String> hashtags;
  final EdgeInsets padding;
  final double fontSize;
  final int maxLines;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final Color color;

  const CollectionCardHashtagsWidget({
    super.key,
    required this.hashtags,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.fontSize = 16.0,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.center,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      margin: padding,
      text: _formatHashtagsList(hashtags),
      fontSize: fontSize,
      maxLines: maxLines,
      textOverflow: textOverflow,
      textAlign: textAlign,
      color: color,
    );
  }

  String _formatHashtagsList(List<String> hashtags) {
    if (hashtags.isEmpty) {
      return '';
    } else {
      return '#${hashtags.join(' #')}';
    }
  }
}
