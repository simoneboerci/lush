import 'package:flutter/material.dart';

import 'package:lush_app/features/chat/presentation/widgets/action_item_direct_overlay_widget.dart';

class ActionMenuDirectOverlayWidget extends StatelessWidget {
  const ActionMenuDirectOverlayWidget({
    super.key,
    required this.actions,
    this.width = 240.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.backgroundColorOpacity = 0.2,
    this.distanceFromMessage = 0.0,
  });

  final List<ActionItemDirectOverlayWidget> actions;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double backgroundColorOpacity;
  final double borderRadius;
  final double distanceFromMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(backgroundColorOpacity),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(color: Colors.transparent),
          ...actions,
        ],
      ),
    );
  }
}

class ActionMenuDirectOverlayPositioner extends StatefulWidget {
  const ActionMenuDirectOverlayPositioner({
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
  State<ActionMenuDirectOverlayPositioner> createState() =>
      _ActionMenuDirectOverlayPositionerState();
}

class _ActionMenuDirectOverlayPositionerState
    extends State<ActionMenuDirectOverlayPositioner> {
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
  void didUpdateWidget(ActionMenuDirectOverlayPositioner oldWidget) {
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

    double top = widget.messagePosition.dy +
        widget.messageSize.height +
        (widget.child as ActionMenuDirectOverlayWidget).distanceFromMessage;

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
