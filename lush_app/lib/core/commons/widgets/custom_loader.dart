import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBackground(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
