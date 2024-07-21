import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/shop_offer_model.dart';

import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/credits_offer_widget.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/lush_tokens_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  _onBasicOfferButtonPressed(BuildContext context, ShopOfferModel offer) {}

  _onCreativeOfferButtonPressed(BuildContext context, ShopOfferModel offer) {}

  _onMagicOfferButtonPressed(BuildContext context, ShopOfferModel offer) {
    try {
      UserModel currentUser =
          Provider.of<UserProvider>(context, listen: false).user!;

      currentUser.purchaseInfo.addLushTokens(offer.offerAmount);
      currentUser.purchaseInfo.redeemOffer(offer);

      Provider.of<UserProvider>(context, listen: false).setUser(currentUser);

      FirebaseHelper().userHelper.storeUserData(currentUser);
    } catch (e) {
      print('Errore durante l acquisto dell offerta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser =
        Provider.of<UserProvider>(context, listen: false).user!;

    return CustomBackground(
      child: StreamBuilder<List<ShopOfferModel>>(
        stream: FirebaseHelper().offersHelper.getCreditsOffersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nessuna offerta disponibile'));
          } else {
            List<ShopOfferModel> magicOffers = [];
            List<ShopOfferModel> creativeOffers = [];
            List<ShopOfferModel> basicOffers = [];
            for (int i = 0; i < snapshot.data!.length; i++) {
              switch (snapshot.data![i].offerType) {
                case ShopOfferType.magic:
                  magicOffers.add(snapshot.data![i]);
                  break;
                case ShopOfferType.creative:
                  creativeOffers.add(snapshot.data![i]);
                  break;
                case ShopOfferType.basic:
                  basicOffers.add(snapshot.data![i]);
                  break;
              }
            }
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Offerte Imperdibili',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Playfair Display',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const Divider(
                  color: cSecondaryColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.0),
                  child: LushTokensWidget.large(),
                ),
                ...creativeOffers.map((offer) => CreditsOfferWidget.creative(
                      offer: offer,
                      padding: const EdgeInsets.only(bottom: 16.0),
                      onPressed: currentUser.purchaseInfo.redeemedOffers
                              .contains(offer.id)
                          ? null
                          : () => _onCreativeOfferButtonPressed(context, offer),
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...basicOffers.map((offer) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: CreditsOfferWidget.basic(
                            offer: offer,
                            onPressed: currentUser.purchaseInfo.redeemedOffers
                                    .contains(offer.id)
                                ? null
                                : () =>
                                    _onBasicOfferButtonPressed(context, offer),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                ...magicOffers.map((offer) => CreditsOfferWidget.magic(
                      offer: offer,
                      onPressed: currentUser.purchaseInfo.redeemedOffers
                              .contains(offer.id)
                          ? null
                          : () => _onMagicOfferButtonPressed(context, offer),
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}
