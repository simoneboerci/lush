import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.contentPadding,
    this.controller,
    this.fillColor,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.filled = false,
    this.borderRadius = 0.0,
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
  });

  const CustomTextField.large({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = kAccentColor,
    this.cursorErrorColor = kSecondaryColor,
    this.cursorHeight = 16.0,
    this.filled = true,
    this.borderRadius = 16.0,
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
  });

  const CustomTextField.small({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 28.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = kAccentColor,
    this.cursorErrorColor = kSecondaryColor,
    this.cursorHeight,
    this.filled = true,
    this.borderRadius = 16.0,
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
  });

  const CustomTextField.smallRounded({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 28.0),
    this.controller,
    this.fillColor = const Color(0xFF333333),
    this.cursorColor = kAccentColor,
    this.cursorErrorColor = kSecondaryColor,
    this.cursorHeight,
    this.filled = true,
    this.borderRadius = 100.0,
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
  });

  final EdgeInsets padding;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final bool filled;
  final double borderRadius;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
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
          hintStyle: TextStyle(
            color: hintTextColor,
          ),
          contentPadding: contentPadding,
          fillColor: fillColor,
          hintText: hintText,
          filled: filled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide,
          ),
        ),
      ),
    );
  }
}
