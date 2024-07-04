import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class ReactionsDirectOverlayWidget extends StatelessWidget {
  const ReactionsDirectOverlayWidget({
    super.key,
    this.reactionBarMaxHeight = 50.0,
    this.reactionBarMargin =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.reactionBarBorderRadius = 25.0,
    this.reactionBarBackgroundColor = cPrimaryColor,
    this.reactionBarPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.reactionBarEmojisSpacing = const EdgeInsets.symmetric(
      horizontal: 4.0,
    ),
    this.reactionBarEmojisSize = 24.0,
    this.reactionBarEmojis = const ['👍', '❤️', '😂', '😮', '😢', '🙏'],
    this.reactionBarShowAddEmojiButton = true,
    this.reactionBarAddEmojiButtonPressed,
  });

  final double reactionBarMaxHeight;
  final EdgeInsets reactionBarMargin;
  final double reactionBarBorderRadius;
  final Color? reactionBarBackgroundColor;
  final EdgeInsets reactionBarPadding;
  final EdgeInsets reactionBarEmojisSpacing;
  final double reactionBarEmojisSize;
  final List<String> reactionBarEmojis;
  final bool reactionBarShowAddEmojiButton;
  final Function()? reactionBarAddEmojiButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: reactionBarMaxHeight,
          minHeight: reactionBarMaxHeight,
        ),
        margin: reactionBarMargin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(reactionBarBorderRadius),
          color: reactionBarBackgroundColor,
        ),
        padding: reactionBarPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...reactionBarEmojis
                .map((emoji) => _buildEmojiButton(emoji, () {})),
            reactionBarShowAddEmojiButton
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      maxHeight: reactionBarMaxHeight,
                    ),
                    onPressed: reactionBarAddEmojiButtonPressed,
                    icon: Icon(
                      Icons.add,
                      color: Colors.yellow,
                      size: reactionBarEmojisSize,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: reactionBarEmojisSpacing,
        child: Text(
          overflow: TextOverflow.fade,
          emoji,
          style: TextStyle(
            fontSize: reactionBarEmojisSize,
          ),
        ),
      ),
    );
  }
}
