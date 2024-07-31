import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/variable_counter_widget.dart';

class RowVariableCountersWidget extends StatelessWidget {
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<VariableCounterWidget> variableCounters;

  const RowVariableCountersWidget({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.variableCounters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: variableCounters,
      ),
    );
  }
}
