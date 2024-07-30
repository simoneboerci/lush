import 'package:flutter/material.dart';
import 'package:lush_app/features/chat/presentation/viewmodels/message_reactions_menu_overlay_positioner_view_model.dart';

class MessageReactionsMenuOverlayPositioner extends StatefulWidget {
  final MessageReactionsMenuOverlayPositionerViewModel viewModel;
  final Widget child;

  const MessageReactionsMenuOverlayPositioner({
    super.key,
    required this.viewModel,
    required this.child,
  });

  @override
  MessageReactionsMenuOverlayPositionerState createState() =>
      MessageReactionsMenuOverlayPositionerState();
}

class MessageReactionsMenuOverlayPositionerState
    extends State<MessageReactionsMenuOverlayPositioner> {
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
  void didUpdateWidget(MessageReactionsMenuOverlayPositioner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel.messagePosition !=
            widget.viewModel.messagePosition ||
        oldWidget.viewModel.messageSize != widget.viewModel.messageSize) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _updateChildSizeAndPosition());
    }
  }

  void _updateChildSizeAndPosition() {
    final RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      final Size newSize = renderBox.size;
      final Offset newPosition = widget.viewModel.calculatePosition(newSize);

      setState(() {
        _childSize = newSize;
        _position = newPosition;
      });
    }
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
