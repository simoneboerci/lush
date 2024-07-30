import 'package:flutter/material.dart';
import 'package:lush_app/features/auth/presentation/viewmodels/logo_widget_view_model.dart';

class LogoWidget extends StatelessWidget {
  final LogoWidgetViewModel viewModel;

  const LogoWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewModel.padding,
      child: Image(
        image: viewModel.getImageFromLogoType(),
        height: viewModel.size,
      ),
    );
  }
}
