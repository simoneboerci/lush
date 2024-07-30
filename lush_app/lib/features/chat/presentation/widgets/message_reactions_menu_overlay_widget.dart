import 'package:flutter/material.dart';

import 'package:lush_app/features/chat/presentation/viewmodels/message_reactions_menu_overlay_widget_view_model.dart';

class MessageReactionsMenuOverlayWidget extends StatelessWidget {
  final MessageReactionsMenuOverlayWidgetViewModel viewModel;

  const MessageReactionsMenuOverlayWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: viewModel.maxHeight,
        minHeight: viewModel.maxHeight,
      ),
      margin: viewModel.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(viewModel.borderRadius),
        color: viewModel.backgroundColor,
      ),
      padding: viewModel.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...viewModel.emojis.map(_buildEmojiButton),
          if (viewModel.showAddEmojiButton) _buildAddEmojiButton(),
        ],
      ),
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return GestureDetector(
      onTap: () => viewModel.onEmojiTapped(emoji),
      child: Padding(
        padding: viewModel.emojisSpacing,
        child: Text(
          emoji,
          style: TextStyle(
            fontSize: viewModel.emojisSize,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }

  Widget _buildAddEmojiButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(maxHeight: viewModel.maxHeight),
      onPressed: viewModel.onAddEmojiPressed,
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: viewModel.emojisSize,
      ),
    );
  }
}
