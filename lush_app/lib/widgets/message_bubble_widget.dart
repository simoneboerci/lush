import 'package:flutter/material.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:video_player/video_player.dart';

import 'package:lush_app/core/constants/colors.dart';

import 'package:lush_app/features/chat/presentation/widgets/action_item_direct_overlay_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/widgets/re_actions_direct_overlay_widget.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.isMe,
    required this.onReplyTap,
    required this.onLongPressActions,
    this.style = const MessageBubbleStyle(),
  });

  final Message message;
  final bool isMe;
  final Function(String) onReplyTap;
  final List<ActionItemDirectOverlayWidget> onLongPressActions;
  final MessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    final GlobalKey messageKey = GlobalKey();

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showReActionsOverlay(context, messageKey),
        child: Container(
          key: messageKey,
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * style.maxMessageBoxLength,
          ),
          decoration: BoxDecoration(
            color: isMe ? style.isMeBackgroundColor : style.backgroundColor,
            borderRadius: isMe ? style.isMeBorderRadius : style.borderRadius,
          ),
          margin: style.padding,
          padding: style.contentPadding,
          child: _MessageContent(
            message: message,
            isMe: isMe,
            style: style,
            onReplyTap: onReplyTap,
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

class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.message,
    required this.isMe,
    required this.style,
    required this.onReplyTap,
  });

  final Message message;
  final bool isMe;
  final MessageBubbleStyle style;
  final Function(String) onReplyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? style.isMeAlign : style.align,
      children: [
        if (message.replyToMessageId != null)
          _RepliedMessage(
            repliedMessage: message,
            style: style,
            onReplyTap: onReplyTap,
          ),
        if (message.mediaUrl != null) _buildMediaPlayer(),
        SizedBox(
          height: message.replyToMessageId != null ? 8.0 : 0,
        ),
        _MessageText(message: message, isMe: isMe, style: style),
        SizedBox(height: style.timestampSpacing),
        _MessageTimestamp(message: message, isMe: isMe, style: style),
      ],
    );
  }

  Widget _buildMediaPlayer() {
    if (message.mediaType == MediaType.image) {
      return Image.network(message.mediaUrl!);
    } else if (message.mediaType == MediaType.video) {
      return VideoPlayerWidget(videoUrl: message.mediaUrl!);
    }

    return const Text('Errore durante il carimento del media');
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<StatefulWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller =
        VideoPlayerController.networkUrl(Uri.dataFromString(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _ControlsOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: controller.value.isPlaying
          ? Container()
          : Container(
              color: Colors.black45,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () {
                    controller.play();
                  },
                ),
              ),
            ),
    );
  }
}

class _RepliedMessage extends StatelessWidget {
  const _RepliedMessage({
    required this.repliedMessage,
    required this.style,
    required this.onReplyTap,
  });

  final Message repliedMessage;
  final MessageBubbleStyle style;
  final Function(String) onReplyTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onReplyTap(repliedMessage.replyToMessageId!),
      child: Container(
        color: style.repliedMessageContainerColor,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(style.repliedMessageBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: repliedMessage.senderId,
              color: style.repliedMessageContactNameColor,
              fontSize: style.repliedMessageContactNameFontSize,
              fontWeight: style.repliedMessageContactNameFontWeight,
            ),
            CustomText(
              text: repliedMessage.text,
              color: style.repliedMessageTextColor,
              fontSize: style.repliedMessageTextFontSize,
              fontWeight: style.repliedMessageTextFontWeight,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageText extends StatelessWidget {
  const _MessageText({
    required this.message,
    required this.isMe,
    required this.style,
  });

  final Message message;
  final bool isMe;
  final MessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: message.text,
      fontSize: isMe ? style.isMeFontSize : style.fontSize,
      color: isMe ? style.isMeTextColor : style.textColor,
      textOverflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}

class _MessageTimestamp extends StatelessWidget {
  const _MessageTimestamp({
    required this.message,
    required this.isMe,
    required this.style,
  });

  final Message message;
  final bool isMe;
  final MessageBubbleStyle style;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text:
          '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
      fontSize: isMe ? style.isMeTimestampFontSize : style.timestampFontSize,
      color: isMe ? style.isMeTimestampColor : style.timestampColor,
    );
  }
}

class MessageBubbleStyle {
  const MessageBubbleStyle({
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    this.contentPadding = const EdgeInsets.all(16.0),
    this.isMeBackgroundColor = cPrimaryColor,
    this.backgroundColor = Colors.white,
    this.isMeAlign = CrossAxisAlignment.end,
    this.align = CrossAxisAlignment.start,
    this.isMeBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(
        16.0,
      ),
      topRight: Radius.circular(
        16.0,
      ),
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
    this.repliedMessageContactNameColor = cPrimaryColor,
    this.repliedMessageTextColor = Colors.black38,
    this.repliedMessageBorderRadius = 16.0,
    this.repliedMessageContainerColor = Colors.black38,
    this.repliedMessageContactNameFontSize = 14.0,
    this.repliedMessageTextFontSize = 14.0,
    this.repliedMessageContactNameFontWeight = FontWeight.bold,
    this.repliedMessageTextFontWeight = FontWeight.normal,
  });

  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final Color isMeBackgroundColor;
  final Color backgroundColor;
  final CrossAxisAlignment isMeAlign;
  final CrossAxisAlignment align;
  final BorderRadius isMeBorderRadius;
  final BorderRadius borderRadius;
  final Color isMeTextColor;
  final Color textColor;
  final double isMeFontSize;
  final double fontSize;
  final Color isMeTimestampColor;
  final Color timestampColor;
  final double isMeTimestampFontSize;
  final double timestampFontSize;
  final double timestampSpacing;
  final double maxMessageBoxLength;
  final Color repliedMessageContainerColor;
  final Color repliedMessageTextColor;
  final Color repliedMessageContactNameColor;
  final double repliedMessageTextFontSize;
  final double repliedMessageContactNameFontSize;
  final double repliedMessageBorderRadius;
  final FontWeight repliedMessageContactNameFontWeight;
  final FontWeight repliedMessageTextFontWeight;
}
