import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class ReactionsDirectOverlayWidget extends StatelessWidget {
  const ReactionsDirectOverlayWidget({
    super.key,
    required this.isMyMessage,
    required this.messageOffset,
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
    this.distanceFromMessage = 56.0,
  });

  final bool isMyMessage;
  final Offset messageOffset;
  final double maxHeight;
  final EdgeInsets margin;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets emojisSpacing;
  final double emojisSize;
  final List<String> emojis;
  final bool showAddEmojiButton;
  final Function()? addEmojiButtonPressed;
  final double distanceFromMessage;

  @override
  Widget build(BuildContext context) {
    return _PositionedReactionsOverlay(
      isMyMessage: isMyMessage,
      messageOffset: messageOffset,
      distanceFromMessage: distanceFromMessage,
      child: _ReactionsContainer(
        maxHeight: maxHeight,
        margin: margin,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        padding: padding,
        emojisSpacing: emojisSpacing,
        emojisSize: emojisSize,
        emojis: emojis,
        showAddEmojiButton: showAddEmojiButton,
        addEmojiButtonPressed: addEmojiButtonPressed,
      ),
    );
  }
}

class _PositionedReactionsOverlay extends StatefulWidget {
  const _PositionedReactionsOverlay({
    required this.isMyMessage,
    required this.messageOffset,
    required this.distanceFromMessage,
    required this.child,
  });

  final bool isMyMessage;
  final Offset messageOffset;
  final double distanceFromMessage;
  final Widget child;

  @override
  _PositionedReactionsOverlayState createState() =>
      _PositionedReactionsOverlayState();
}

class _PositionedReactionsOverlayState
    extends State<_PositionedReactionsOverlay> {
  final GlobalKey _containerKey = GlobalKey();
  double _leftPosition = 0.0;
  double _widgetOpacity = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
    super.initState();
  }

  void _updatePosition() {
    final renderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final screenWidth = MediaQuery.of(context).size.width;
      setState(() {
        _leftPosition = widget.isMyMessage
            ? screenWidth - renderBox.size.width
            : widget.messageOffset.dx;
        _widgetOpacity = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _widgetOpacity,
      child: Positioned(
        key: _containerKey,
        left: _leftPosition,
        top: widget.messageOffset.dy - widget.distanceFromMessage,
        child: widget.child,
      ),
    );
  }
}

class _ReactionsContainer extends StatelessWidget {
  const _ReactionsContainer({
    required this.maxHeight,
    required this.margin,
    required this.borderRadius,
    required this.backgroundColor,
    required this.padding,
    required this.emojisSpacing,
    required this.emojisSize,
    required this.emojis,
    required this.showAddEmojiButton,
    required this.addEmojiButtonPressed,
  });

  final double maxHeight;
  final EdgeInsets margin;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets emojisSpacing;
  final double emojisSize;
  final List<String> emojis;
  final bool showAddEmojiButton;
  final VoidCallback? addEmojiButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: maxHeight,
      ),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...emojis.map(_buildEmojiButton),
          if (showAddEmojiButton) _buildAddEmojiButton(),
        ],
      ),
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return GestureDetector(
      onTap: () {}, //TODO: Iimplement emoji reaction logic
      child: Padding(
        padding: emojisSpacing,
        child: Text(
          emoji,
          style: TextStyle(
            fontSize: emojisSize,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }

  Widget _buildAddEmojiButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(maxHeight: maxHeight),
      onPressed: addEmojiButtonPressed,
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: emojisSize,
      ),
    );
  }
}
