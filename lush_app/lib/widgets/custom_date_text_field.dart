import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:lush_app/widgets/custom_text_field.dart';

class CustomDateTextField extends StatefulWidget {
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

  @override
  State<CustomDateTextField> createState() => _CustomDateTextFieldState();
}

class _CustomDateTextFieldState extends State<CustomDateTextField> {
  @override
  Widget build(BuildContext context) {
    Future<void> showDatePickerOnPressed() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        barrierColor: widget.datePickerBarrierColor,
        helpText: widget.datePickerHelpText,
        cancelText: widget.datePickerCancelText,
        confirmText: widget.datePickerConfirmText,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child ?? Container(),
          );
        },
      );

      if (pickedDate != null) {
        setState(() {
          widget.controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        });
      }
    }

    return CustomTextField.large(
      controller: widget.controller,
      onTap: () => showDatePickerOnPressed(),
      hintText: widget.hintText,
    );
  }
}
