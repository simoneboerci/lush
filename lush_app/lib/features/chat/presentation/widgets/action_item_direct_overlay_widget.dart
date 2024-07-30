import 'package:flutter/material.dart';
import 'package:lush_app/features/chat/presentation/viewmodels/action_overlay_menu_item_view_model.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class ActionItemDirectOverlayWidget extends StatelessWidget {
  final ActionOverlayMenuItemViewModel viewModel;

  const ActionItemDirectOverlayWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: viewModel.onTap,
          borderRadius: BorderRadius.circular(viewModel.borderRadius),
          child: Padding(
            padding: viewModel.textPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: viewModel.label,
                  fontSize: viewModel.textFontSize,
                  color: viewModel.textColor,
                ),
                Icon(
                  viewModel.icon,
                  color: viewModel.iconColor,
                  size: viewModel.iconSize,
                ),
              ],
            ),
          ),
        ),
        viewModel.divider,
      ],
    );
  }
}
