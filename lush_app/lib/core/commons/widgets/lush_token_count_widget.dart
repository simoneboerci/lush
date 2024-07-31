import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/constants/images.dart';

class LushTokenCountWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double spacing;
  final double iconSize;
  final ImageProvider icon;

  const LushTokenCountWidget({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.italic,
    this.spacing = 8.0,
    this.iconSize = 25.0,
    this.icon = cLushTokenIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: '1.500', //TODO: Implementreal time data
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ),
        SizedBox(width: spacing),
        Image(
          width: iconSize,
          image: icon,
        ),
      ],
    );
  }
}
