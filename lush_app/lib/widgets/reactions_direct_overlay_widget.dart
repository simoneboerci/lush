import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class ReactionsDirectOverlayWidget extends StatefulWidget {
  const ReactionsDirectOverlayWidget({
    super.key,
    this.maxHeight = 50.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.borderRadius = 25.0,
    this.backgroundColor = cPrimaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.emojisSpacing = const EdgeInsets.symmetric(
      horizontal: 4.0,
    ),
    this.emojisSize = 24.0,
    this.emojis = const ['👍', '❤️', '😂', '😮', '😢', '🙏'],
    this.showAddEmojiButton = true,
    this.addEmojiButtonPressed,
    required this.isMyMessage,
    required this.messageOffset,
    this.distanceFromMessage = 56.0,
  });

  final double maxHeight;
  final EdgeInsets margin;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets emojisSpacing;
  final double emojisSize;
  final List<String> emojis;
  final bool showAddEmojiButton;
  final Function()? addEmojiButtonPressed;
  final double distanceFromMessage;

  final bool isMyMessage;
  final Offset messageOffset;

  @override
  ReactionsDirectOverlayWidgetState createState() =>
      ReactionsDirectOverlayWidgetState();
}

class ReactionsDirectOverlayWidgetState
    extends State<ReactionsDirectOverlayWidget> {
  final GlobalKey _containerKey = GlobalKey();
  double _leftPosition = 0.0;
  double _widgetOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _updateLeftPosition();
  }

  void _updateLeftPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox?;
      final screenWidth = MediaQuery.of(context).size.width;
      if (renderBox != null) {
        setState(() {
          _leftPosition = widget.isMyMessage
              ? screenWidth - renderBox.size.width
              : widget.messageOffset.dx;
          _widgetOpacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _widgetOpacity,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: _leftPosition,
              top: widget.messageOffset.dy - widget.distanceFromMessage,
              child: Container(
                key: _containerKey,
                constraints: BoxConstraints(
                  maxHeight: widget.maxHeight,
                  minHeight: widget.maxHeight,
                ),
                margin: widget.margin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.backgroundColor,
                ),
                padding: widget.padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...widget.emojis
                        .map((emoji) => _buildEmojiButton(emoji, () {})),
                    widget.showAddEmojiButton
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              maxHeight: widget.maxHeight,
                            ),
                            onPressed: widget.addEmojiButtonPressed,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: widget.emojisSize,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: widget.emojisSpacing,
        child: Text(
          overflow: TextOverflow.fade,
          emoji,
          style: TextStyle(
            fontSize: widget.emojisSize,
          ),
        ),
      ),
    );
  }
}
