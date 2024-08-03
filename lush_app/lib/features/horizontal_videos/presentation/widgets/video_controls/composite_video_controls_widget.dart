import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CompositeVideoControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final List<Widget> components;
  final EdgeInsets padding;
  final Color backgroundColor;

  const CompositeVideoControlsWidget({
    super.key,
    required this.controller,
    required this.components,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Stack(
        children: components,
      ),
    );
  }
}
