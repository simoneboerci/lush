import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.validator,
    this.contentPadding,
    this.controller,
    this.fillColor,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.filled = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
    this.borderSide = BorderSide.none,
    this.obscureText = false,
    this.textStyleHeight,
    this.textColor,
    this.hintTextColor,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.maxLines,
    this.maxHeight = double.infinity,
  });

  const CustomTextField.large({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.validator,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = cSecondaryColor,
    this.cursorErrorColor = cSecondaryColor,
    this.cursorHeight = 16.0,
    this.filled = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.borderSide = BorderSide.none,
    this.obscureText = false,
    this.textStyleHeight = 2.0,
    this.textColor = Colors.white,
    this.hintTextColor = Colors.white30,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.maxLines = 1,
    this.maxHeight = double.infinity,
  });

  const CustomTextField.small({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.validator,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = cSecondaryColor,
    this.cursorErrorColor = cSecondaryColor,
    this.cursorHeight,
    this.filled = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.borderSide = BorderSide.none,
    this.obscureText = false,
    this.textStyleHeight,
    this.textColor = Colors.white,
    this.hintTextColor = Colors.white30,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor = Colors.white30,
    this.maxLines = 1,
    this.maxHeight = double.infinity,
  });

  const CustomTextField.smallRounded({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.validator,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = cSecondaryColor,
    this.cursorErrorColor = cSecondaryColor,
    this.cursorHeight,
    this.filled = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(25.0)),
    this.borderSide = BorderSide.none,
    this.obscureText = false,
    this.textStyleHeight,
    this.textColor = Colors.white,
    this.hintTextColor = Colors.white30,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.maxLines,
    this.maxHeight = 150.0,
  });

  final EdgeInsets padding;
  final String? Function(String?)? validator;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final bool filled;
  final BorderRadius borderRadius;
  final BorderSide borderSide;
  final bool obscureText;
  final double? textStyleHeight;
  final Color? textColor;
  final Color? hintTextColor;
  final String? hintText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final Icon? prefixIcon;
  final Color? prefixIconColor;
  final int? maxLines;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: TextFormField(
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          cursorColor: cursorColor,
          cursorErrorColor: cursorErrorColor,
          cursorHeight: cursorHeight,
          controller: controller,
          style: TextStyle(height: textStyleHeight, color: textColor),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor,
            hintStyle: TextStyle(color: hintTextColor),
            contentPadding: contentPadding,
            fillColor: fillColor,
            hintText: hintText,
            filled: filled,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide,
            ),
          ),
          maxLines: maxLines,
        ),
      ),
    );
  }
}
