import 'package:flutter/material.dart';

import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';

class ActionMenuDirectOverlayWidget extends StatelessWidget {
  const ActionMenuDirectOverlayWidget({
    super.key,
    required this.isMyMessage,
    required this.messageOffset,
    required this.messageHeight,
    required this.actions,
    this.width = 240.0,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 4.0,
    ),
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.backgroundColorOpacity = 0.2,
  });

  final bool isMyMessage;
  final Offset messageOffset;
  final double messageHeight;
  final List<ActionItemDirectOverlayWidget> actions;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double backgroundColorOpacity;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return _ActionMenuPositioned(
      isMyMessage: isMyMessage,
      messageOffset: messageOffset,
      messageHeight: messageHeight,
      child: _ActionMenuContainer(
        width: width,
        margin: margin,
        borderRadius: borderRadius,
        padding: padding,
        backgroundColor: backgroundColor,
        backgroundColorOpacity: backgroundColorOpacity,
        actions: actions,
      ),
    );
  }
}

class _ActionMenuPositioned extends StatefulWidget {
  const _ActionMenuPositioned({
    required this.isMyMessage,
    required this.messageOffset,
    required this.messageHeight,
    required this.child,
  });

  final bool isMyMessage;
  final Offset messageOffset;
  final double messageHeight;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _ActionMenuPositionedState();
}

class _ActionMenuPositionedState extends State<_ActionMenuPositioned> {
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
        top: widget.messageOffset.dy + widget.messageHeight,
        child: widget.child,
      ),
    );
  }
}

class _ActionMenuContainer extends StatelessWidget {
  const _ActionMenuContainer({
    required this.width,
    required this.margin,
    required this.borderRadius,
    required this.padding,
    required this.backgroundColor,
    required this.backgroundColorOpacity,
    required this.actions,
  });

  final double width;
  final EdgeInsets? margin;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double backgroundColorOpacity;
  final List<ActionItemDirectOverlayWidget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
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
