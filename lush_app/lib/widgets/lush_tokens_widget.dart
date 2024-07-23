import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/constants/images.dart';

class LushTokensWidget extends StatelessWidget {
  const LushTokensWidget({
    super.key,
    this.padding = const EdgeInsets.all(8.0),
    this.imageWidth = 40.0,
    this.textColor = Colors.white,
    this.fontSize = 30.0,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  final EdgeInsets padding;
  final double imageWidth;
  final Color textColor;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          StreamBuilder<int>(
              stream: FirebaseHelper.getTokensCountStreamFromCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Errore: ${snapshot.error}',
                    style: TextStyle(color: Colors.red, fontSize: fontSize),
                  );
                } else if (snapshot.hasData) {
                  return Text(
                    NumberFormat.decimalPattern('vi_VN').format(snapshot.data!),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  );
                } else {
                  return Text(
                    'N/A',
                    style: TextStyle(color: textColor, fontSize: fontSize),
                  );
                }
              }),
          const SizedBox(
            width: 8.0,
          ),
          Image(
            width: imageWidth,
            image: cLushTokenIcon,
          ),
        ],
      ),
    );
  }
}
