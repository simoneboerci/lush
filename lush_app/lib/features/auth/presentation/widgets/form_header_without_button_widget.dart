import 'package:flutter/material.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class FormHeaderWithoutButtonWidget extends StatelessWidget {
  final FormHeaderWidgetViewModel viewModel;

  const FormHeaderWithoutButtonWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewModel.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LogoWidget(
              viewModel: LogoWidgetViewModel.fromLogoType(viewModel.logoType)),
          CustomText(
            text: viewModel.text,
            color: viewModel.textColor,
          ),
        ],
      ),
    );
  }
}
