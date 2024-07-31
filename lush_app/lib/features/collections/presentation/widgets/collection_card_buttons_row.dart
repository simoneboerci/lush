import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';

class CollectionCardButtonsRow extends StatelessWidget {
  final EdgeInsets padding;
  final List<CustomIconButton> firstIconGroup;
  final List<CustomIconButton> secondIconGroup;

  const CollectionCardButtonsRow({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.firstIconGroup = const [],
    this.secondIconGroup = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: firstIconGroup,
          ),
          ...secondIconGroup,
        ],
      ),
    );
  }
}
