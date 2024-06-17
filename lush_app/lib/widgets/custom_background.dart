import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
    this.padding = const EdgeInsets.all(28.0),
    this.child,
  });

  final EdgeInsets padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: kBackgroundGradient,
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
