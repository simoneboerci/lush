import 'package:flutter/material.dart';

import 'package:lush_app/core/constants/fonts.dart';

enum FontType {
  title,
  text,
  google,
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.margin = EdgeInsets.zero,
    required this.text,
    this.fontSize,
    this.fontType = FontType.text,
    this.fontWeight,
    this.textAlign,
    this.color = Colors.white,
    this.textOverflow,
    this.maxLines,
    this.softWrap,
    this.fontStyle,
    this.shadows,
  });

  final EdgeInsets margin;
  final String text;
  final double? fontSize;
  final FontType fontType;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final bool? softWrap;
  final FontStyle? fontStyle;
  final List<Shadow>? shadows;

  String _getFontFamily() => switch (fontType) {
        FontType.title => cTitleFont,
        FontType.text => cTextFont,
        FontType.google => cGoogleFont,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        style: TextStyle(
          fontFamily: _getFontFamily(),
          shadows: shadows,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
