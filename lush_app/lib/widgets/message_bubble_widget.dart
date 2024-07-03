import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/models/direct_message.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.isMe,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    this.contentPadding = const EdgeInsets.all(16.0),
    this.isMeBackgroundColor = cPrimaryColor,
    this.backgroundColor = Colors.white,
    this.isMeAlign = CrossAxisAlignment.end,
    this.align = CrossAxisAlignment.start,
    this.isMeBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
    ),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    ),
    this.isMeTextColor = Colors.white,
    this.textColor = Colors.black,
    this.isMeFontSize = 16.0,
    this.fontSize = 16.0,
    this.isMeTimestampColor = Colors.white,
    this.timestampColor = Colors.black,
    this.isMeTimestampFontSize = 12.0,
    this.timestampFontSize = 12.0,
  });

  final DirectMessage message;
  final bool isMe;

  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final Color? isMeBackgroundColor;
  final Color? backgroundColor;
  final CrossAxisAlignment isMeAlign;
  final CrossAxisAlignment align;
  final BorderRadius isMeBorderRadius;
  final BorderRadius borderRadius;
  final Color? isMeTextColor;
  final Color? textColor;
  final double isMeFontSize;
  final double fontSize;
  final Color? isMeTimestampColor;
  final Color? timestampColor;
  final double isMeTimestampFontSize;
  final double timestampFontSize;

  @override
  Widget build(BuildContext context) {
    final currentBackgroundColor = isMe ? isMeBackgroundColor : backgroundColor;
    final currentAlign = isMe ? isMeAlign : align;
    final currentBorderRadius = isMe ? isMeBorderRadius : borderRadius;
    final currentTextColor = isMe ? isMeTextColor : textColor;
    final currentFontSize = isMe ? isMeFontSize : fontSize;
    final currentTimestampColor = isMe ? isMeTimestampColor : timestampColor;
    final currentTimestampFontSize =
        isMe ? isMeTimestampFontSize : timestampFontSize;

    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: currentBackgroundColor,
          borderRadius: currentBorderRadius,
        ),
        margin: padding,
        padding: contentPadding,
        child: Column(
          crossAxisAlignment: currentAlign,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: currentFontSize,
                color: currentTextColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${message.timestamp.toDate().hour.toStringAsPrecision(2)}:${message.timestamp.toDate().minute.toStringAsPrecision(2)}',
              style: TextStyle(
                fontSize: currentTimestampFontSize,
                color: currentTimestampColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
