import 'package:flutter/material.dart';

class VideoCardWidget extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;
  final Widget child;

  const VideoCardWidget({
    super.key,
    this.margin = const EdgeInsets.only(top: 8.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.backgroundColor = Colors.black26,
    this.borderRadius = 8.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
