import 'package:flutter/material.dart';

import 'package:lush_app/features/chat/presentation/viewmodels/unread_message_bubble_view_model.dart';

import 'package:lush_app/core/commons/widgets/custom_text.dart';

class UnreadMessageBubbleWidget extends StatelessWidget {
  final UnreadMessageBubbleViewModel viewModel;

  const UnreadMessageBubbleWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: viewModel.maxHeight,
      ),
      margin: viewModel.margin,
      padding: viewModel.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(viewModel.borderRadius),
        color: viewModel.bubbleColor,
      ),
      child: CustomText(
        textAlign: viewModel.textAlign,
        text: viewModel.unreadMessagesText,
        color: viewModel.textColor,
        fontType: viewModel.textFontFamily,
        fontWeight: viewModel.textFontWeight,
        fontSize: viewModel.textFontSize,
      ),
    );
  }
}
