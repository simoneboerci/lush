import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
    this.padding = const EdgeInsets.all(28.0),
    this.child,
    this.appBar,
  });

  final EdgeInsets padding;
  final Widget? child;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
          decoration: const BoxDecoration(
            gradient: kBackgroundGradient,
          ),
          padding: padding,
          child: child ?? Container()),
    );
  }
}
