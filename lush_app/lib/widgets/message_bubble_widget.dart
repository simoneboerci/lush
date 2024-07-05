import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/models/direct_message.dart';

import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';
import 'package:lush_app/widgets/re_actions_direct_overlay_widget.dart';

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
    this.timestampSpacing = 4.0,
    this.maxMessageBoxLength = 0.75,
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
  final double timestampSpacing;
  final double maxMessageBoxLength;

  @override
  Widget build(BuildContext context) {
    final GlobalKey messageKey = GlobalKey();

    final currentBackgroundColor = isMe ? isMeBackgroundColor : backgroundColor;
    final currentAlign = isMe ? isMeAlign : align;
    final currentBorderRadius = isMe ? isMeBorderRadius : borderRadius;
    final currentTextColor = isMe ? isMeTextColor : textColor;
    final currentFontSize = isMe ? isMeFontSize : fontSize;
    final currentTimestampColor = isMe ? isMeTimestampColor : timestampColor;
    final currentTimestampFontSize =
        isMe ? isMeTimestampFontSize : timestampFontSize;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showReActionsOverlay(context, messageKey),
        child: Container(
          key: messageKey,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * maxMessageBoxLength,
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
              SizedBox(height: timestampSpacing),
              Text(
                '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: currentTimestampFontSize,
                  color: currentTimestampColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReActionsOverlay(BuildContext context, GlobalKey messageKey) {
    ReActionsDirectOverlayWidget.showReActionsDirectOverlay(
      context: context,
      isMe: isMe,
      messageWidget: this,
      messageKey: messageKey,
      actions: [
        ActionItemDirectOverlayWidget(
          label: 'Aggiungi ai preferiti',
          icon: Icons.bookmark_border,
          onTap: () {},
        ),
        ActionItemDirectOverlayWidget(
          label: 'Rispondi',
          icon: Icons.replay,
          onTap: () {},
        ),
        ActionItemDirectOverlayWidget(
          label: 'Copia',
          icon: Icons.content_copy,
          onTap: () {},
        ),
        ActionItemDirectOverlayWidget(
          label: 'Fissa',
          icon: Icons.push_pin_outlined,
          onTap: () {},
        ),
        ActionItemDirectOverlayWidget(
          label: 'Segnala',
          icon: Icons.flag_outlined,
          onTap: () {},
        ),
        ActionItemDirectOverlayWidget(
          label: 'Elimina',
          icon: Icons.delete_outlined,
          iconColor: cPrimaryColor,
          textColor: cPrimaryColor,
          onTap: () {},
          addDivider: false,
        ),
      ],
    );
  }
}
