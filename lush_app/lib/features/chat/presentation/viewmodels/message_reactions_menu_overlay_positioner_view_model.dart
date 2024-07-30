import 'package:flutter/material.dart';

class MessageReactionsMenuOverlayPositionerViewModel {
  final bool isMe;
  final Offset messagePosition;
  final Size messageSize;
  final double distanceFromMessage;

  MessageReactionsMenuOverlayPositionerViewModel({
    required this.isMe,
    required this.messagePosition,
    required this.messageSize,
    this.distanceFromMessage = 0.0,
  });

  Offset calculatePosition(Size childSize) {
    double left;
    if (isMe) {
      left = messagePosition.dx + messageSize.width - childSize.width;
    } else {
      left = messagePosition.dx;
    }

    double top = messagePosition.dy - childSize.height - distanceFromMessage;

    return Offset(left, top);
  }
}
