import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';

import 'package:lush_app/widgets/action_menu_direct_overlay_widget.dart';
import 'package:lush_app/widgets/reactions_direct_overlay_widget.dart';

class ReActionsDirectOverlayWidget {
  static void showReActionsDirectOverlay({
    required BuildContext context,
    required bool isMe,
    required Widget messageWidget,
    required GlobalKey messageKey,
    double backgroundBlurAmount = 20.0,
    double backgroundOpacity = 0.7,
    required List<ActionItemDirectOverlayWidget> actions,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final RenderBox renderBox =
        messageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset messagePosition = renderBox.localToGlobal(Offset.zero);
    final Size messageSize = renderBox.size;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: backgroundBlurAmount,
                      sigmaY: backgroundBlurAmount),
                  child: Container(
                      color: Colors.black.withOpacity(backgroundOpacity)),
                ),
              ),
              Positioned(
                left:
                    isMe ? screenWidth - messageSize.width : messagePosition.dx,
                top: messagePosition.dy,
                child: messageWidget,
              ),
              ReactionsDirectOverlayWidget(
                isMyMessage: isMe,
                messageOffset: messagePosition,
              ),
              ActionMenuDirectOverlayWidget(
                isMyMessage: isMe,
                messageOffset: messagePosition,
                messageHeight: messageSize.height,
                actions: actions,
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => overlayEntry.remove(),
                  behavior: HitTestBehavior.translucent,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}
