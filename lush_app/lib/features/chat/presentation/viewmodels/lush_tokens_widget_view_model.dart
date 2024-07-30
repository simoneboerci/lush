import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LushTokensWidgetViewModel {
  final EdgeInsets padding;
  final double imageWidth;
  final Color textColor;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;

  const LushTokensWidgetViewModel({
    this.padding = EdgeInsets.zero,
    this.imageWidth = 26.0,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  const LushTokensWidgetViewModel.large({
    this.padding = const EdgeInsets.all(8.0),
    this.imageWidth = 40.0,
    this.textColor = Colors.white,
    this.fontSize = 30.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  Future<void> updateTokensCount() async {}

  String formatTokensCount(int tokensCount) {
    return NumberFormat.decimalPattern('vi_VN').format(tokensCount);
  }
}
