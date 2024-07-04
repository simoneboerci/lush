import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/models/direct_message.dart';
import 'package:lush_app/widgets/action_menu_direct_overlay_widget.dart';
import 'package:lush_app/widgets/re_actions_direct_overlay_widget.dart';
import 'package:lush_app/widgets/reactions_direct_overlay_widget.dart';

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

  void _showReactionAndMenu(
      BuildContext context, RenderBox box, Offset offset) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isRightAligned = isMe;

    final reactionBarPosition = isRightAligned
        ? Offset(screenWidth - 250, offset.dy - 50)
        : Offset(offset.dx, offset.dy - 50);

    final menuPosition = isRightAligned
        ? Offset(screenWidth - 200, offset.dy + box.size.height)
        : Offset(offset.dx, offset.dy + box.size.height);

    OverlayEntry reactionBarEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: reactionBarPosition.dx,
        top: reactionBarPosition.dy,
        child: const ReactionsDirectOverlayWidget(),
      ),
    );

    OverlayEntry menuEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: menuPosition.dx,
        top: menuPosition.dy,
        child: const ActionMenuDirectOverlayWidget(),
      ),
    );

    Overlay.of(context).insert(reactionBarEntry);
    Overlay.of(context).insert(menuEntry);

    // Rimuovi gli overlay dopo un tap ovunque sullo schermo
    void removeOverlays(event) {
      reactionBarEntry.remove();
      menuEntry.remove();
    }

    /*Future.delayed(Duration.zero, () {
      GestureBinding.instance.pointerRouter
          .addGlobalRoute((PointerEvent event) {
        if (event is PointerDownEvent) {
          removeOverlays(event);
          GestureBinding.instance.pointerRouter
              .removeGlobalRoute(removeOverlays);
        }
      });
    });*/
  }

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

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset offset = box.localToGlobal(Offset.zero);
          _showReactionAndMenu(context, box, offset);
        },
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
                '${message.timestamp.toDate().hour.toString().padLeft(2, '0')}:${message.timestamp.toDate().minute.toString().padLeft(2, '0')}',
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
}
