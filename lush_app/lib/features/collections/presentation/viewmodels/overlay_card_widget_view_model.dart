import 'package:flutter/material.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';

class OverlayCardWidgetViewModel {
  final CollectionCard card;
  final double widthOverlayFactor;
  final double heightOverlayFactor;
  final Color backgroundColor;
  final Color frameColor;
  final double backgroundBorderRadius;
  final double frameBorderWidth;

  final ValueNotifier<Offset> offsetNotifier =
      ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<Offset> tiltNotifier = ValueNotifier<Offset>(Offset.zero);

  bool isDragging = false;

  OverlayCardWidgetViewModel({
    required this.card,
    this.widthOverlayFactor = 0.95,
    this.heightOverlayFactor = 0.75,
    this.backgroundColor = const Color.fromARGB(255, 23, 23, 23),
    this.frameColor = Colors.amber,
    this.backgroundBorderRadius = 8.0,
    this.frameBorderWidth = 8,
  });

  double getOverlayWidth(double screenWidth) =>
      screenWidth * widthOverlayFactor;
  double getOverlayHeight(double screenHeight) =>
      screenHeight * heightOverlayFactor;

  void onPanUpdate(DragUpdateDetails details, Size screenSize) {
    offsetNotifier.value += details.delta;
    tiltNotifier.value = Offset(
      details.localPosition.dx / (screenSize.width * widthOverlayFactor) - 0.5,
      details.localPosition.dy / (screenSize.height * heightOverlayFactor) -
          0.5,
    );
  }

  void resetValues() {
    offsetNotifier.value = Offset.zero;
    tiltNotifier.value = Offset.zero;
  }
}
