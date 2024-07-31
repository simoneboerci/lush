import 'package:flutter/material.dart';

class CollectionCardFrameWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double borderRadius;
  final Color color;
  final double borderWidth;

  const CollectionCardFrameWidget({
    super.key,
    this.padding = const EdgeInsets.all(12.0),
    required this.borderRadius,
    this.color = Colors.white,
    this.borderWidth = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color,
          width: borderWidth,
        ),
      ),
    );
  }
}
