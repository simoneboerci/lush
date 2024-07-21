import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/models/message_model.dart';

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
    this.repliedMessage,
    this.repliedMessageContactNameColor = cPrimaryColor,
    this.repliedMessageTextColor = Colors.black38,
    this.repliedMessageBorderRadius = 16.0,
    this.repliedMessageContainerColor = Colors.black38,
    this.repliedMessageContactNameFontSize = 14.0,
    this.repliedMessageTextFontSize = 14.0,
    this.repliedMessageContactNameFontWeight = FontWeight.bold,
    this.repliedMessageTextFontWeight = FontWeight.normal,
    required this.onReplyTap,
    required this.onLongPressActions,
  });

  final MessageModel? message;
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

  final MessageModel? repliedMessage;
  final Color? repliedMessageContainerColor;
  final Color? repliedMessageTextColor;
  final Color? repliedMessageContactNameColor;
  final double repliedMessageTextFontSize;
  final double repliedMessageContactNameFontSize;
  final double repliedMessageBorderRadius;
  final FontWeight repliedMessageContactNameFontWeight;
  final FontWeight repliedMessageTextFontWeight;
  final Function(String) onReplyTap;

  final List<ActionItemDirectOverlayWidget> onLongPressActions;

  @override
  Widget build(BuildContext context) {
    final GlobalKey messageKey = GlobalKey(); // Ripristina il GlobalKey

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
          key: messageKey, // Aggiungi il GlobalKey al Container
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
              if (repliedMessage != null)
                InkWell(
                  onTap: () => onReplyTap(message!.replyToMessageId!),
                  child: Container(
                    color: repliedMessageContainerColor,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(repliedMessageBorderRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repliedMessage!.senderId,
                          style: TextStyle(
                            color: repliedMessageContactNameColor,
                            fontSize: repliedMessageContactNameFontSize,
                            fontWeight: repliedMessageContactNameFontWeight,
                          ),
                        ),
                        Text(
                          repliedMessage!.text,
                          style: TextStyle(
                            color: repliedMessageTextColor,
                            fontSize: repliedMessageTextFontSize,
                            fontWeight: repliedMessageTextFontWeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(
                  height: repliedMessage != null
                      ? 8.0
                      : 0), // Spazio tra il messaggio risposto e il messaggio attuale
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width * maxMessageBoxLength,
                ),
                child: Text(
                  message!.text,
                  style: TextStyle(
                    fontSize: currentFontSize,
                    color: currentTextColor,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: timestampSpacing),
              Text(
                '${message?.timestamp.hour.toString().padLeft(2, '0')}:${message?.timestamp.minute.toString().padLeft(2, '0')}',
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
    ReActionsDirectOverlayWidget.show(
      context: context,
      isMe: isMe,
      messageWidget: this,
      messageKey: messageKey,
      actions: onLongPressActions,
    );
  }
}
