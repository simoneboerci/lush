import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class ReactionsDirectOverlayWidget extends StatelessWidget {
  const ReactionsDirectOverlayWidget({
    super.key,
    this.maxHeight = 50.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.borderRadius = 25.0,
    this.backgroundColor = cPrimaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.emojisSpacing = const EdgeInsets.symmetric(horizontal: 4.0),
    this.emojisSize = 24.0,
    this.emojis = const ['👍', '❤️', '😂', '😮', '😢', '🙏'],
    this.showAddEmojiButton = true,
    this.addEmojiButtonPressed,
    this.distanceFromMessage = 0.0,
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
  final Function()? addEmojiButtonPressed;
  final double distanceFromMessage;

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
      onTap: () {}, //TODO: Implement emoji reaction logic
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

class ReactionsDirectOverlayPositioner extends StatefulWidget {
  const ReactionsDirectOverlayPositioner({
    super.key,
    required this.child,
    required this.isMe,
    required this.messagePosition,
    required this.messageSize,
  });

  final Widget child;
  final bool isMe;
  final Offset messagePosition;
  final Size messageSize;

  @override
  ReactionsDirectOverlayPositionerState createState() =>
      ReactionsDirectOverlayPositionerState();
}

class ReactionsDirectOverlayPositionerState
    extends State<ReactionsDirectOverlayPositioner> {
  final GlobalKey _childKey = GlobalKey();
  Size? _childSize;
  Offset? _position;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _updateChildSizeAndPosition());
  }

  @override
  void didUpdateWidget(ReactionsDirectOverlayPositioner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messagePosition != widget.messagePosition ||
        oldWidget.messageSize != widget.messageSize) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _updateChildSizeAndPosition());
    }
  }

  void _updateChildSizeAndPosition() {
    final RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      final Size newSize = renderBox.size;
      final Offset newPosition = _calculatePosition(newSize);

      setState(() {
        _childSize = newSize;
        _position = newPosition;
      });
    }
  }

  Offset _calculatePosition(Size childSize) {
    double left;
    if (widget.isMe) {
      left = widget.messagePosition.dx +
          widget.messageSize.width -
          childSize.width;
    } else {
      left = widget.messagePosition.dx;
    }

    double top = widget.messagePosition.dy -
        childSize.height -
        (widget.child as ReactionsDirectOverlayWidget).distanceFromMessage;

    return Offset(left, top);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_position == null || _childSize == null)
          Opacity(
            opacity: 0,
            child: Container(key: _childKey, child: widget.child),
          ),
        if (_position != null && _childSize != null)
          Positioned(
            left: _position!.dx,
            top: _position!.dy,
            child: widget.child,
          ),
      ],
    );
  }
}
