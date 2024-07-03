import 'package:flutter/material.dart';
import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/models/lush_user.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/lush_credits_offer.dart';
import 'package:lush_app/services/user_provider.dart';

import 'package:lush_app/widgets/credits_offer_widget.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/lush_tokens_widget.dart';

import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  _onBasicOfferButtonPressed(BuildContext context, LushCreditsOffer offer) {}

  _onCreativeOfferButtonPressed(BuildContext context, LushCreditsOffer offer) {}

  _onMagicOfferButtonPressed(BuildContext context, LushCreditsOffer offer) {
    try {
      LushUser currentUser =
          Provider.of<UserProvider>(context, listen: false).user!;

      currentUser.addLushTokens(offer.offerAmount);
      currentUser.redeemOffer(offer);

      Provider.of<UserProvider>(context, listen: false).setUser(currentUser);

      FirebaseHelper.storeUserData(currentUser);
    } catch (e) {
      print('Errore durante l acquisto dell offerta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    LushUser currentUser =
        Provider.of<UserProvider>(context, listen: false).user!;

    return CustomBackground(
      child: StreamBuilder<List<LushCreditsOffer>>(
        stream: FirebaseHelper.getCreditsOffersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nessuna offerta disponibile'));
          } else {
            List<LushCreditsOffer> magicOffers = [];
            List<LushCreditsOffer> creativeOffers = [];
            List<LushCreditsOffer> basicOffers = [];
            for (int i = 0; i < snapshot.data!.length; i++) {
              switch (snapshot.data![i].offerType) {
                case CreditsOfferType.magic:
                  magicOffers.add(snapshot.data![i]);
                  break;
                case CreditsOfferType.creative:
                  creativeOffers.add(snapshot.data![i]);
                  break;
                case CreditsOfferType.basic:
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
                  child: LushTokensWidget(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                ...creativeOffers.map((offer) => CreditsOfferWidget.creative(
                      offer: offer,
                      padding: const EdgeInsets.only(bottom: 16.0),
                      onPressed: currentUser.reedemedOffers!.contains(offer.id)
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
                            onPressed: currentUser.reedemedOffers!
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
                      onPressed: currentUser.reedemedOffers!.contains(offer.id)
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
