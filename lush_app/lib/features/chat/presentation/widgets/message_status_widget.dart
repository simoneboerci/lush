import 'package:flutter/material.dart';

import 'package:lush_app/features/chat/presentation/viewmodels/message_status_view_model.dart';

class MessageStatusWidget extends StatelessWidget {
  final MessageStatusViewModel viewModel;

  const MessageStatusWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel.status == MessageStatusDisplay.none) {
      return const SizedBox.shrink();
    }

    return Icon(
      viewModel.icon,
      color: viewModel.color,
      size: viewModel.iconSize,
    );
  }
}
