import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/widgets/custom_text_field.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.padding = const EdgeInsets.only(bottom: 50.0),
    this.onMessageSent,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final EdgeInsets padding;
  final Function(String)? onMessageSent;

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
                controller: controller,
                hintText: 'Scrivi un messaggio...',
                onChanged: onChanged,
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return value.text.isEmpty
                  ? _buildPhotoAndAudioIcon()
                  : _buildSendMessageButton();
            },
          ),
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

  Widget _buildSendMessageButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton.filled(
        style: IconButton.styleFrom(backgroundColor: cPrimaryColor),
        onPressed: () {
          final message = controller.text;
          if (message.isNotEmpty) {
            onMessageSent?.call(message);
            controller.clear();
          }
        },
        icon: const Icon(Icons.send),
      ),
    );
  }
}
