import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/routes.dart';

class VerificationCompletedScreenViewModel {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final EdgeInsets primaryButtonMargin;
  final Color primaryButtonBackgroundColor;
  final String primaryButtonText;
  final Color primaryButtonTextColor;
  final EdgeInsets titlePadding;
  final String titleText;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color titleColor;
  final EdgeInsets textPadding;
  final TextAlign textTextAlign;
  final String textText;
  final FontWeight textFontWeight;
  final double textFontSize;
  final Color textColor;

  const VerificationCompletedScreenViewModel({
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.primaryButtonMargin = const EdgeInsets.symmetric(vertical: 16.0),
    this.primaryButtonBackgroundColor = Colors.transparent,
    this.primaryButtonText = 'Torna alla schermata principale ->',
    this.primaryButtonTextColor = Colors.white,
    this.titlePadding = const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    this.titleText = 'Congratulazioni!',
    this.titleFontSize = 18.0,
    this.titleFontWeight = FontWeight.bold,
    this.titleColor = Colors.white,
    this.textPadding = const EdgeInsets.only(top: 8.0),
    this.textTextAlign = TextAlign.center,
    this.textText =
        'Riceverai una notifica non appena\nil processo di verifica sarà\ncompleto',
    this.textColor = Colors.white,
    this.textFontSize = 16.0,
    this.textFontWeight = FontWeight.w300,
  });

  void onReturnToMainScreenButtonPressed(BuildContext context) {
    _returnToMainScreen(context);
  }

  void _returnToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, cLoginScreen);
  }
}
