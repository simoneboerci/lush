import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class VariableCounterWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double maxWidth;
  final MainAxisAlignment mainAxisAlignment;
  final String variableText;
  final FontWeight variableTextFontWeight;
  final double variableTextFontSize;
  final String label;
  final double labelFontSize;

  const VariableCounterWidget({
    super.key,
    this.padding = EdgeInsets.zero,
    this.maxWidth = 100.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.variableText,
    this.variableTextFontWeight = FontWeight.bold,
    this.variableTextFontSize = 18.0,
    required this.label,
    this.labelFontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: 100.0,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            CustomText(
              text: variableText,
              fontWeight: variableTextFontWeight,
              fontSize: variableTextFontSize,
            ),
            CustomText(
              text: label,
              fontSize: labelFontSize,
            ),
          ],
        ),
      ),
    );
  }
}
