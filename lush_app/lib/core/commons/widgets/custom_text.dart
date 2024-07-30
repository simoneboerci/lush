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
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
