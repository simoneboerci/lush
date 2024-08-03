import 'dart:ui';

import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double borderSize;
  final double blurAmount;

  const PostWidget({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    this.borderSize = 3.0,
    this.blurAmount = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Padding(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [_buildFrame(), _buildImage()],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurAmount,
        sigmaY: blurAmount,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderSize),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/lush-1a59b.appspot.com/o/horizontalVideos%2FD4qkGCbbUosCJy25UEAx%2F6-1-986932-52.jpg?alt=media&token=b0e23834-dc63-453c-91fe-f6ca2046349e',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFrame() {
    return Container(color: Colors.amber);
  }
}
