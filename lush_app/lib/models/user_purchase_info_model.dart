import 'package:tuple/tuple.dart';

import 'package:lush_app/models/shop_offer_model.dart';

class UserPurchaseInfoModel {
  final int lushTokens;
  final List<String> redeemedOffers;

  static const lushTokensLabel = 'lush_tokens';
  static const redeemedOffersLabel = 'redeemed_offers';

  UserPurchaseInfoModel({
    this.lushTokens = 0,
    this.redeemedOffers = const [],
  });

  factory UserPurchaseInfoModel.fromMap(Map<String, dynamic> map) {
    return UserPurchaseInfoModel(
      lushTokens:
          map[lushTokensLabel] != null ? map[lushTokensLabel] as int : 0,
      redeemedOffers: map[redeemedOffersLabel] != null
          ? List<String>.from(map[redeemedOffersLabel] as List<dynamic>)
          : const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      lushTokensLabel: lushTokens,
      redeemedOffersLabel: redeemedOffers,
    };
  }

  UserPurchaseInfoModel copyWith({
    int? lushTokens,
    List<String>? redeemedOffers,
  }) {
    return UserPurchaseInfoModel(
      lushTokens: lushTokens ?? this.lushTokens,
      redeemedOffers: redeemedOffers ?? this.redeemedOffers,
    );
  }

  UserPurchaseInfoModel addLushTokens(int amount) {
    return copyWith(
      lushTokens: lushTokens + amount,
    );
  }

  Tuple2<UserPurchaseInfoModel, bool> subtractLushtokens(int amount) {
    if (lushTokens >= amount) {
      return Tuple2(
        copyWith(lushTokens: lushTokens - amount),
        true,
      );
    } else {
      return Tuple2(
        this,
        false,
      );
    }
  }

  Tuple2<UserPurchaseInfoModel, bool> redeemOffer(ShopOfferModel offer) {
    if (redeemedOffers.contains(offer.id)) {
      return Tuple2(
        this,
        false,
      );
    } else {
      return Tuple2(
        copyWith(redeemedOffers: [...redeemedOffers, offer.id]),
        true,
      );
    }
  }
}
