import 'package:flutter/material.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/check_icon_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/verification/verification_completed_screen_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/check_icon_widget.dart';
import 'package:lush_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_elevated_button.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class VerificationCompletedScreen extends StatelessWidget {
  final VerificationCompletedScreenViewModel viewModel =
      const VerificationCompletedScreenViewModel();

  const VerificationCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      padding: viewModel.margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoWidget(viewModel: LogoWidgetViewModel.lightBlue()),
                Padding(
                  padding: viewModel.titlePadding,
                  child: CustomText(
                    text: viewModel.titleText,
                    fontSize: viewModel.titleFontSize,
                    fontWeight: viewModel.titleFontWeight,
                    color: viewModel.titleColor,
                  ),
                ),
                const CheckIconWidget(viewModel: CheckIconWidgetViewModel()),
                Padding(
                  padding: viewModel.textPadding,
                  child: CustomText(
                    textAlign: viewModel.textTextAlign,
                    text: viewModel.textText,
                    fontWeight: viewModel.textFontWeight,
                    fontSize: viewModel.textFontSize,
                    color: viewModel.textColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: viewModel.primaryButtonMargin,
            child: CustomElevatedButton(
              elevation: 0.0,
              backgroundColor: viewModel.primaryButtonBackgroundColor,
              text: viewModel.primaryButtonText,
              textColor: viewModel.primaryButtonTextColor,
              onPressed: () =>
                  viewModel.onReturnToMainScreenButtonPressed(context),
            ),
          ),
        ],
      ),
    );
  }
}
