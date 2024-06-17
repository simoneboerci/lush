import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/constants/images.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_elevated_button.dart';

class VerificationCompletedScreen extends StatelessWidget {
  const VerificationCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CustomElevatedButton(
              backgroundColor: Colors.transparent,
              text: 'Torna alla schermata principale ->',
              textColor: Colors.transparent,
              fontFamily: 'Montserrat',
            ),
          ),
          Column(
            children: [
              const Image(
                image: cLightLightBlueLogo,
                height: 50.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Congratulazioni!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: cSecondaryColor,
                    borderRadius: BorderRadius.circular(10000.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(60.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Image(
                        image: cCheckIconImage,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Riceverai una notifica non appena\nil processo di verifica sarà\ncompleto',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CustomElevatedButton(
              backgroundColor: Colors.transparent,
              text: 'Torna alla schermata principale ->',
              textColor: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}
