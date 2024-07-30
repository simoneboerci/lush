import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';

import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/chat/presentation/viewmodels/send_message_widget_view_model.dart';

class SendMessageWidget extends StatelessWidget {
  final SendMessageWidgetViewModel viewModel;
  final EdgeInsets padding;

  const SendMessageWidget({
    super.key,
    required this.viewModel,
    this.padding = const EdgeInsets.only(bottom: 50.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextField.smallRounded(
                controller: viewModel.textController,
                hintText: 'Scrivi un messaggio...',
              ),
            ),
          ),
          viewModel.isMessageEmpty
              ? _buildPhotoAndAudioIcon()
              : _buildSendMessageButton(viewModel),
        ],
      ),
    );
  }

  Widget _buildPhotoAndAudioIcon() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          color: cSecondaryColor,
          icon: const Icon(Icons.camera_alt_outlined),
          iconSize: 30.0,
        ),
        IconButton(
          onPressed: () {},
          color: cSecondaryColor,
          icon: const Icon(Icons.mic_none_outlined),
          iconSize: 40.0,
        ),
      ],
    );
  }

  Widget _buildSendMessageButton(SendMessageWidgetViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton.filled(
        style: IconButton.styleFrom(backgroundColor: cPrimaryColor),
        onPressed: viewModel.sendMessage,
        icon: const Icon(Icons.send),
      ),
    );
  }
}
