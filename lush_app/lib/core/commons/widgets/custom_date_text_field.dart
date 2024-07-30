import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lush_app/core/commons/widgets/custom_text_field.dart';

class CustomDateTextField extends StatelessWidget {
  const CustomDateTextField({
    super.key,
    required this.controller,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.hintText,
    this.datePickerBarrierColor,
    this.datePickerHelpText,
    this.datePickerCancelText,
    this.datePickerConfirmText,
  });

  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? hintText;
  final Color? datePickerBarrierColor;
  final String? datePickerHelpText;
  final String? datePickerCancelText;
  final String? datePickerConfirmText;

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      barrierColor: datePickerBarrierColor,
      helpText: datePickerHelpText,
      cancelText: datePickerCancelText,
      confirmText: datePickerConfirmText,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null && controller.text.isEmpty) {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField.large(
      controller: controller,
      onTap: () => _showDatePicker(context),
      hintText: hintText,
    );
  }
}
