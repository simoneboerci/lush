import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/widgets/custom_text.dart';

class UnreadMessageBubbleWidget extends StatelessWidget {
  const UnreadMessageBubbleWidget({
    super.key,
    required this.unreadMessages,
    this.margin = const EdgeInsets.all(4.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.bubbleColor = cSecondaryColor,
    this.textColor = cSurfaceColor,
    this.textFontSize = 12.0,
    this.textFontWeight = FontWeight.normal,
    this.textFontFamily = FontType.text,
    this.borderRadius = 100.0,
    this.maxHeight = 36.0,
    this.textAlign = TextAlign.end,
  });

  final int unreadMessages;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color? bubbleColor;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final FontType textFontFamily;
  final double borderRadius;
  final double maxHeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: bubbleColor,
      ),
      child: CustomText(
        textAlign: textAlign,
        text: unreadMessages.toString(),
        color: textColor,
        fontType: textFontFamily,
        fontWeight: textFontWeight,
        fontSize: textFontSize,
      ),
    );
  }
}
