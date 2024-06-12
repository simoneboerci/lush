import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/widgets/custom_icon_button.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({
    super.key,
    this.image = cLightPinkLogo,
    this.hintText = 'Clicca qui per inserire\nla tua immagine profilo',
    this.text = 'Completa il tuo\nprofilo per cotinuare',
    this.onPressed,
    this.showButton = false,
  });

  final AssetImage image;
  final String hintText;
  final String text;
  final Function()? onPressed;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    if (!showButton) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: image,
              height: 50.0,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                hintText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Image(
                width: 50,
                image: cArrowImage,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: image,
                      height: 50.0,
                    ),
                    const SizedBox(
                      width: 66.0,
                    ),
                    CustomIconButton.large(
                      icon: Icons.add,
                      onPressed: onPressed,
                    )
                  ],
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
