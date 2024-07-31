import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class CollectionCardTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final int maxLines;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  final double strokeSize;
  final double strokeBlurRadius;
  final Color strokeColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;
  final Color shadowColor;

  const CollectionCardTextWidget.title({
    super.key,
    required this.text,
    this.fontSize = 72.0,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.white,
    this.strokeSize = 2.0,
    this.strokeBlurRadius = 4.0,
    this.strokeColor = Colors.black,
    this.shadowOffset = const Offset(0.0, 16.0),
    this.shadowBlurRadius = 42.0,
    this.shadowColor = Colors.black,
  });

  const CollectionCardTextWidget.subtitle({
    super.key,
    required this.text,
    this.fontSize = 30.0,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.white,
    this.strokeSize = 1.0,
    this.strokeBlurRadius = 4.0,
    this.strokeColor = Colors.black,
    this.shadowOffset = const Offset(0.0, 8.0),
    this.shadowBlurRadius = 42.0,
    this.shadowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: fontSize,
      maxLines: maxLines,
      textOverflow: textOverflow,
      textAlign: textAlign,
      fontWeight: fontWeight,
      color: color,
      shadows: [
        ..._buildTextStroke(),
        _buildTextShadow(),
      ],
    );
  }

  List<Shadow> _buildTextStroke() {
    return [
      Shadow(
        offset: Offset(0.0, strokeSize),
        blurRadius: strokeBlurRadius,
        color: strokeColor,
      ),
      Shadow(
        offset: Offset(0.0, -strokeSize),
        blurRadius: strokeBlurRadius,
        color: strokeColor,
      ),
      Shadow(
        offset: Offset(strokeSize, 0.0),
        blurRadius: strokeBlurRadius,
        color: strokeColor,
      ),
      Shadow(
        offset: Offset(-strokeSize, 0.0),
        blurRadius: strokeBlurRadius,
        color: strokeColor,
      ),
    ];
  }

  Shadow _buildTextShadow() {
    return Shadow(
      offset: shadowOffset,
      blurRadius: shadowBlurRadius,
      color: shadowColor,
    );
  }
}
