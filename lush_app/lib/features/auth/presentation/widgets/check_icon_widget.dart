import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/images.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/check_icon_widget_view_model.dart';

class CheckIconWidget extends StatelessWidget {
  final CheckIconWidgetViewModel viewModel;

  const CheckIconWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewModel.margin,
      child: Container(
        decoration: BoxDecoration(
          color: viewModel.backgroundColor,
          borderRadius: BorderRadius.circular(viewModel.borderRadius),
        ),
        child: Padding(
          padding: viewModel.padding,
          child: SizedBox(
            width: viewModel.iconSize,
            height: viewModel.iconSize,
            child: const Image(image: cCheckIconImage),
          ),
        ),
      ),
    );
  }
}
