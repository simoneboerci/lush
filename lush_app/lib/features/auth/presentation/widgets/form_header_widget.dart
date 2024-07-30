import 'package:flutter/material.dart';

import 'package:lush_app/features/auth/presentation/viewmodels/registration_header_widget_view_model.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_header_with_button_widget.dart';
import 'package:lush_app/features/auth/presentation/widgets/form_header_without_button_widget.dart';

class FormHeaderWidget extends StatelessWidget {
  final FormHeaderWidgetViewModel viewModel;

  const FormHeaderWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return viewModel.showButton
        ? FormHeaderWithButtonWidget(viewModel: viewModel)
        : FormHeaderWithoutButtonWidget(viewModel: viewModel);
  }
}
