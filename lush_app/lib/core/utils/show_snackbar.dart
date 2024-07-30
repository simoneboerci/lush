import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: CustomText(text: content),
      ),
    );
}
