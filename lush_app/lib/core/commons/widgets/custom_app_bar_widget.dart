import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/commons/widgets/lush_token_count_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool showTokensCount;
  final EdgeInsets padding;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.showTokensCount = false,
    this.padding = const EdgeInsets.only(bottom: 30.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: showTokensCount
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitleText(),
                const LushTokenCountWidget(),
              ],
            )
          : _buildTitleText(),
    );
  }

  Widget _buildTitleText() {
    return CustomText(
      text: title,
      fontType: FontType.title,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 21.0,
    );
  }
}
