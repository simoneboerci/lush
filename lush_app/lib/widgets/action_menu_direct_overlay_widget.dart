import 'package:flutter/material.dart';

import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';

class ActionMenuDirectOverlayWidget extends StatefulWidget {
  const ActionMenuDirectOverlayWidget({
    super.key,
    this.width = 240.0,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 4.0,
    ),
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.backgroundColorOpacity = 0.2,
    required this.isMyMessage,
    required this.messageOffset,
    required this.messageHeight,
    required this.actions,
  });

  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double backgroundColorOpacity;
  final double borderRadius;
  final List<ActionItemDirectOverlayWidget> actions;

  final bool isMyMessage;
  final Offset messageOffset;
  final double messageHeight;

  @override
  State<ActionMenuDirectOverlayWidget> createState() =>
      _ActionMenuDirectOverlayWidgetState();
}

class _ActionMenuDirectOverlayWidgetState
    extends State<ActionMenuDirectOverlayWidget> {
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
          _containerKey.currentContext?.findRenderObject() as RenderBox?;
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
              top: widget.messageOffset.dy + widget.messageHeight,
              child: Container(
                key: _containerKey,
                width: widget.width,
                margin: widget.margin,
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: widget.backgroundColor
                      .withOpacity(widget.backgroundColorOpacity),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(
                      color: Colors.transparent,
                    ),
                    ...widget.actions,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
