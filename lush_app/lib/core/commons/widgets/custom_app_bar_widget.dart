import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/commons/widgets/lush_token_count_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool showTokensCount;
  final FontType fontType;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double fontSize;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.showTokensCount = false,
    this.fontType = FontType.title,
    this.fontWeight = FontWeight.bold,
    this.fontStyle = FontStyle.italic,
    this.fontSize = 21.0,
  });

  @override
  Widget build(BuildContext context) {
    return showTokensCount
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitleText(),
              const LushTokenCountWidget(),
            ],
          )
        : _buildTitleText();
  }

  Widget _buildTitleText() {
    return CustomText(
      text: title,
      fontType: fontType,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: fontSize,
    );
  }
}
