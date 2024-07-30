import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/images.dart';

enum LogoType {
  lightPink,
  lightBlue,
  darkPink,
  darkBlue,
  pinkTongue,
  lushToken,
}

class LogoWidgetViewModel {
  final EdgeInsets padding;
  final LogoType logoType;
  final double size;

  factory LogoWidgetViewModel.fromLogoType(LogoType logoType) {
    return switch (logoType) {
      LogoType.lightPink => const LogoWidgetViewModel.lightPink(),
      LogoType.lightBlue => const LogoWidgetViewModel.lightBlue(),
      LogoType.darkPink => const LogoWidgetViewModel.darkPink(),
      LogoType.darkBlue => const LogoWidgetViewModel.darkBlue(),
      LogoType.pinkTongue =>
        const LogoWidgetViewModel.lightPink(), // TODO: Implementare costruttore
      LogoType.lushToken =>
        const LogoWidgetViewModel.lightPink(), // TODO: Implementare costruttore
    };
  }

  const LogoWidgetViewModel.lightPink({
    this.padding = EdgeInsets.zero,
    this.logoType = LogoType.lightPink,
    this.size = 50.0,
  });

  const LogoWidgetViewModel.lightBlue({
    this.padding = EdgeInsets.zero,
    this.logoType = LogoType.lightBlue,
    this.size = 50.0,
  });

  const LogoWidgetViewModel.darkPink({
    this.padding = EdgeInsets.zero,
    this.logoType = LogoType.darkPink,
    this.size = 50.0,
  });

  const LogoWidgetViewModel.darkBlue({
    this.padding = EdgeInsets.zero,
    this.logoType = LogoType.darkBlue,
    this.size = 50.0,
  });

  //TODO: Pink tongue constructor

  //TODO: Lush token constructor

  ImageProvider getImageFromLogoType() {
    return switch (logoType) {
      LogoType.lightPink => cLightPinkLogo,
      LogoType.lightBlue => cLightBlueLogo,
      LogoType.darkPink => cDarkPinkLogo,
      LogoType.darkBlue => cDarkBlueLogo,
      LogoType.pinkTongue => cPinkTongue,
      LogoType.lushToken => cLushTokenIcon,
    };
  }
}
