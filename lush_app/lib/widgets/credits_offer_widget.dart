import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/lush_credits_offer.dart';

class CreditsOfferWidget extends StatelessWidget {
  const CreditsOfferWidget.magic({
    super.key,
    required this.offer,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.onPressed,
    this.backgroundColor = cSecondaryColor,
    this.labelTextColor = Colors.white,
    this.timerTextColor = Colors.white,
    this.fullPriceTextColor = Colors.white,
    this.discountedPriceTextColor = Colors.white,
    this.currencyLabelTextColor = Colors.white,
    this.borderRadius = 16.0,
    this.contentPadding = const EdgeInsets.all(50.0),
    this.labelFontSize = 30.0,
    this.timerFontSize = 30.0,
    this.priceFontSize = 30.0,
    this.imageSize = 27.0,
    this.image = cPinkTongue,
    this.offerType = CreditsOfferType.magic,
    this.disabledBackgroundColor = cSurfaceColor,
  });

  const CreditsOfferWidget.creative({
    super.key,
    required this.offer,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.onPressed,
    this.backgroundColor = cSurfaceColor,
    this.labelTextColor = Colors.white,
    this.timerTextColor = cSecondaryColor,
    this.fullPriceTextColor = Colors.white,
    this.discountedPriceTextColor = Colors.white,
    this.currencyLabelTextColor = Colors.white,
    this.borderRadius = 16.0,
    this.contentPadding =
        const EdgeInsets.only(left: 28.0, top: 16.0, bottom: 16.0),
    this.labelFontSize = 18.0,
    this.timerFontSize = 16.0,
    this.priceFontSize = 24.0,
    this.imageSize = 27.0,
    this.image = cPinkTongue,
    this.offerType = CreditsOfferType.creative,
    this.disabledBackgroundColor,
  });

  const CreditsOfferWidget.basic({
    super.key,
    required this.offer,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.onPressed,
    this.backgroundColor = cSurfaceColor,
    this.labelTextColor = Colors.white,
    this.timerTextColor = cSecondaryColor,
    this.fullPriceTextColor = Colors.white,
    this.discountedPriceTextColor = Colors.white,
    this.currencyLabelTextColor = Colors.white,
    this.borderRadius = 16.0,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
    this.labelFontSize = 18.0,
    this.timerFontSize = 16.0,
    this.priceFontSize = 24.0,
    this.imageSize = 27.0,
    this.image = cPinkTongue,
    this.offerType = CreditsOfferType.basic,
    this.disabledBackgroundColor,
  });

  final LushCreditsOffer offer;
  final EdgeInsets padding;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelTextColor;
  final Color? timerTextColor;
  final Color? fullPriceTextColor;
  final Color? discountedPriceTextColor;
  final Color? currencyLabelTextColor;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final double labelFontSize;
  final double timerFontSize;
  final double priceFontSize;
  final double imageSize;
  final AssetImage image;
  final CreditsOfferType offerType;
  final Color? disabledBackgroundColor;

  String _getPriceString() {
    if (offer.discountedPrice == null ||
        offer.discountedPrice == offer.fullPrice) {
      if (offer.fullPrice == 0.0) {
        return 'FREE';
      } else {
        return '${offer.fullPrice}€';
      }
    } else {
      if (offer.discountedPrice == 0.0) {
        return '${offer.fullPrice}€ => FREE';
      } else {
        return '${offer.fullPrice}€ => ${offer.discountedPrice}€';
      }
    }
  }

  Widget _buildSelectedOfferBasedOnType(BuildContext context) {
    switch (offerType) {
      case CreditsOfferType.magic:
        return _buildMagicOfferWidget();
      case CreditsOfferType.creative:
        return _buildCreativeOfferWidget();
      case CreditsOfferType.basic:
        return _buildBasicOfferWidget(context);
    }
  }

  Widget _buildBasicOfferWidget(BuildContext context) {
    return SizedBox(
      height: 280.0,
      width: MediaQuery.sizeOf(context).width / 2.0 - 36.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackgroundColor,
          padding: contentPadding,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              offer.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: labelFontSize),
            ),
            Text(
              'offer.timer!.tick.toString()',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: timerTextColor,
                fontSize: timerFontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreativeOfferWidget() {
    return Material(
      color: cSurfaceColor,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: contentPadding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.label,
                            style: TextStyle(
                              color: labelTextColor,
                              fontSize: labelFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            'offer.timer!.tick.toString()',
                            style: TextStyle(
                              color: timerTextColor,
                              fontSize: timerFontSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _getPriceString(),
                            style: TextStyle(
                              color: fullPriceTextColor,
                              fontSize: priceFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  Ink(
                    width: 70,
                    decoration: const BoxDecoration(
                      color: cPrimaryColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.shop,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMagicOfferWidget() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: contentPadding,
          disabledBackgroundColor: disabledBackgroundColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: imageSize,
              image: image,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    offer.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: labelTextColor,
                      fontSize: labelFontSize,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  Text(
                    _getPriceString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: discountedPriceTextColor,
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: _buildSelectedOfferBasedOnType(context),
    );
  }
}
