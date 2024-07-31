import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/commons/widgets/lush_token_count_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool showTokensCount;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.showTokensCount = false,
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
      fontType: FontType.title,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 21.0,
    );
  }
}
