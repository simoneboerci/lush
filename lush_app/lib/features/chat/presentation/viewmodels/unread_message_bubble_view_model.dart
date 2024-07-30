import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class UnreadMessageBubbleViewModel {
  final int unreadMessages;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color bubbleColor;
  final Color textColor;
  final double textFontSize;
  final FontWeight textFontWeight;
  final FontType textFontFamily;
  final double borderRadius;
  final double maxHeight;
  final TextAlign textAlign;

  UnreadMessageBubbleViewModel({
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

  String get unreadMessagesText => unreadMessages.toString();
}
