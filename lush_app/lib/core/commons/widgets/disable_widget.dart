import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';

class DisableWidget extends StatelessWidget {
  final Widget child;
  final bool isDisabled;

  const DisableWidget({
    super.key,
    required this.child,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        if (isDisabled)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.red,
                  child: const CustomText(
                    text: 'DISABLED',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
