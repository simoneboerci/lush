import 'package:flutter/material.dart';

class CollectionCardImageWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double borderRadius;
  final String imageUrl;
  final BoxFit fit;
  final double width;
  final double height;

  const CollectionCardImageWidget({
    super.key,
    this.padding = const EdgeInsets.all(16.0),
    required this.borderRadius,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl,
          fit: fit,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
