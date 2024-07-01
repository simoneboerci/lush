import 'package:flutter/material.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/lush_credits_offer.dart';

import 'package:lush_app/widgets/credits_offer_widget.dart';
import 'package:lush_app/widgets/custom_background.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                switch (snapshot.data![index].offerType) {
                  case CreditsOfferType.magic:
                    return CreditsOfferWidget.magic(
                      offer: snapshot.data![index],
                      onPressed: () {},
                    );
                  case CreditsOfferType.creative:
                    return CreditsOfferWidget.creative(
                      offer: snapshot.data![index],
                      onPressed: () {},
                    );
                  case CreditsOfferType.basic:
                    return Container();
                }
              },
            );
          }
        },
      ),
    );
  }
}
