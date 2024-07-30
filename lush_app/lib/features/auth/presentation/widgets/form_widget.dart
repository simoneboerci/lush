import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/form_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_header_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_elevated_button.dart';
import 'package:lush_app/core/commons/widgets/custom_form.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class FormWidget extends StatelessWidget {
  final FormWidgetViewModel viewModel;

  const FormWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormHeader(context),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildForm(context),
                                if (viewModel.useSecondaryButton)
                                  _buildSecondaryButton(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (viewModel.useTextButton) _buildTextButton(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormHeader(BuildContext context) {
    return FormHeaderWidget(viewModel: viewModel.headerViewModel);
  }

  Widget _buildForm(BuildContext context) {
    return CustomForm(
      formKey: viewModel.formKey,
      textFields: viewModel.textFields,
      button: CustomElevatedButton(
        backgroundColor: viewModel.primaryButtonBackgroundColor,
        disable: viewModel.disablePrimaryButton,
        padding: viewModel.primaryButtonPadding,
        text: viewModel.primaryButtonText,
        textColor: viewModel.primaryButtonTextColor,
        onPressed: viewModel.primaryButtonOnPressed,
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: viewModel.secondaryButtonPadding,
          child: const CustomText(
            text: 'Oppure',
            color: Colors.white,
          ),
        ),
        CustomElevatedButton.google(
          disable: viewModel.disableSecondaryButton,
          text: viewModel.secondaryButtonText,
          onPressed: viewModel.secondaryButtonOnPressed,
        ),
      ],
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: viewModel.disableTextButton == true
          ? null
          : viewModel.textButtonOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: cPrimaryColor,
      ),
      child: CustomText(
        text: viewModel.textButtonText,
        fontSize: viewModel.textButtonFontSize,
      ),
    );
  }
}
