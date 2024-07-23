import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';
import 'package:lush_app/widgets/action_menu_direct_overlay_widget.dart';
import 'package:lush_app/widgets/reactions_direct_overlay_widget.dart';

class ReActionsDirectOverlayWidget {
  static OverlayEntry show({
    required BuildContext context,
    required bool isMe,
    required Widget messageWidget,
    required GlobalKey messageKey,
    required List<ActionItemDirectOverlayWidget> actions,
    double backgroundBlurAmount = 20.0,
    double backgroundOpacity = 0.7,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final RenderBox renderBox =
        messageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset messagePosition = renderBox.localToGlobal(Offset.zero);
    final Size messageSize = renderBox.size;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ReActionsOverlay(
        isMe: isMe,
        messageWidget: messageWidget,
        messagePosition: messagePosition,
        messageSize: messageSize,
        screenWidth: screenWidth,
        actions: actions,
        backgroundBlurAmount: backgroundBlurAmount,
        backgroundOpacity: backgroundOpacity,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }
}

class _ReActionsOverlay extends StatelessWidget {
  const _ReActionsOverlay({
    required this.isMe,
    required this.messageWidget,
    required this.messagePosition,
    required this.messageSize,
    required this.screenWidth,
    required this.actions,
    required this.backgroundBlurAmount,
    required this.backgroundOpacity,
    required this.onDismiss,
  });

  final bool isMe;
  final Widget messageWidget;
  final Offset messagePosition;
  final Size messageSize;
  final double screenWidth;
  final List<ActionItemDirectOverlayWidget> actions;
  final double backgroundBlurAmount;
  final double backgroundOpacity;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            _buildBlurredBackground(),
            _buildMessageWidget(),
            _buildReactionsOverlay(context),
            _buildActionsMenu(context),
            _buildDismissibleArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurredBackground() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: backgroundBlurAmount,
          sigmaY: backgroundBlurAmount,
        ),
        child: Container(
          color: Colors.black.withOpacity(backgroundOpacity),
        ),
      ),
    );
  }

  Widget _buildMessageWidget() {
    return Positioned(
      left: isMe ? screenWidth - messageSize.width : messagePosition.dx,
      top: messagePosition.dy,
      child: messageWidget,
    );
  }

  Widget _buildReactionsOverlay(BuildContext context) {
    return ReactionsDirectOverlayPositioner(
      isMe: isMe,
      messagePosition: messagePosition,
      messageSize: messageSize,
      child: const ReactionsDirectOverlayWidget(),
    );
  }

  Widget _buildActionsMenu(BuildContext context) {
    return ActionMenuDirectOverlayPositioner(
      isMe: isMe,
      messagePosition: messagePosition,
      messageSize: messageSize,
      child: ActionMenuDirectOverlayWidget(actions: actions),
    );
  }

  Widget _buildDismissibleArea() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        behavior: HitTestBehavior.translucent,
      ),
    );
  }
}
