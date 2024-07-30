import 'package:flutter/material.dart';

import 'package:lush_app/core/constants/images.dart';
import 'package:lush_app/features/chat/presentation/viewmodels/lush_tokens_widget_view_model.dart';

class LushTokensWidget extends StatelessWidget {
  final LushTokensWidgetViewModel viewModel;

  const LushTokensWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewModel.padding,
      child: Row(
        mainAxisAlignment: viewModel.mainAxisAlignment,
        children: [
          Text(
            //viewModel.formatTokensCount(snapshot.data!),
            '0', //TODO: Implementare loading dei dati
            textAlign: TextAlign.end,
            style: TextStyle(
              color: viewModel.textColor,
              fontSize: viewModel.fontSize,
            ),
          ),
          const SizedBox(width: 8.0),
          Image(
            width: viewModel.imageWidth,
            image: cLushTokenIcon,
          ),
        ],
      ),
    );
  }
}
