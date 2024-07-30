import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/images.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class FormHeaderWithButtonWidget extends StatelessWidget {
  final FormHeaderWidgetViewModel viewModel;
  const FormHeaderWithButtonWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: viewModel.hintText,
              color: viewModel.hintTextColor,
            ),
            const SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Image(
                image: cArrowImage,
                height: viewModel.arrowImageSize,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoWidget(
                    viewModel:
                        LogoWidgetViewModel.fromLogoType(viewModel.logoType),
                  ),
                  const SizedBox(width: 66.0),
                  CustomIconButton.large(
                    icon: Icons.add,
                    onPressed: viewModel.onPressed,
                  )
                ],
              ),
              CustomText(
                text: viewModel.text,
                color: viewModel.textColor,
                fontSize: viewModel.textFontSize,
              ),
            ],
          ),
        )
      ],
    );
  }
}
