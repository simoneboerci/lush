import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';

class MessageReactionsMenuOverlayWidgetViewModel {
  final double maxHeight;
  final EdgeInsets margin;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets emojisSpacing;
  final double emojisSize;
  final List<String> emojis;
  final bool showAddEmojiButton;
  final VoidCallback? onAddEmojiPressed;
  final double distanceFromMessage;

  const MessageReactionsMenuOverlayWidgetViewModel({
    this.maxHeight = 50.0,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 4.0,
    ),
    this.borderRadius = 25.0,
    this.backgroundColor = cPrimaryColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
    ),
    this.emojisSpacing = const EdgeInsets.symmetric(
      horizontal: 4.0,
    ),
    this.emojisSize = 24.0,
    this.emojis = const ['👍', '❤️', '😂', '😮', '😢', '🙏'],
    this.showAddEmojiButton = true,
    this.onAddEmojiPressed,
    this.distanceFromMessage = 0.0,
  });

  void onEmojiTapped(String emoji) {
    //TODO: Implementa la logica per la reazione emoji
  }
}
