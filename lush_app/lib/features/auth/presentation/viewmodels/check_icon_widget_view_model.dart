import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';

class CheckIconWidgetViewModel {
  final EdgeInsets margin;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double iconSize;

  const CheckIconWidgetViewModel({
    this.margin = const EdgeInsets.symmetric(vertical: 28.0),
    this.backgroundColor = cSecondaryColor,
    this.borderRadius = 10000.0,
    this.padding = const EdgeInsets.all(60.0),
    this.iconSize = 100.0,
  });
}
