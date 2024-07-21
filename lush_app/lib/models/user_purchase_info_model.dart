import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:tuple/tuple.dart';

import 'package:lush_app/models/shop_offer_model.dart';

enum UserPurchaseInfoField {
  lushTokens,
  redeemedOffers,
}

@immutable
class UserPurchaseInfoModel extends Equatable {
  final int lushTokens;
  final List<String> redeemedOffers;

  const UserPurchaseInfoModel({
    this.lushTokens = 0,
    this.redeemedOffers = const [],
  });

  factory UserPurchaseInfoModel.fromMap(Map<String, dynamic> map) {
    return UserPurchaseInfoModel(
      lushTokens: map[UserPurchaseInfoField.lushTokens.name] as int? ?? 0,
      redeemedOffers:
          (map[UserPurchaseInfoField.redeemedOffers.name] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserPurchaseInfoField.lushTokens.name: lushTokens,
      UserPurchaseInfoField.redeemedOffers.name: redeemedOffers,
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
    if (amount < 0) {
      throw ArgumentError('Amount must be non-negative');
    }
    return copyWith(lushTokens: lushTokens + amount);
  }

  Tuple2<UserPurchaseInfoModel, bool> subtractLushtokens(int amount) {
    if (amount < 0) {
      throw ArgumentError('Amount must be non-negative');
    }
    if (lushTokens >= amount) {
      return Tuple2(copyWith(lushTokens: lushTokens - amount), true);
    } else {
      return Tuple2(this, false);
    }
  }

  Tuple2<UserPurchaseInfoModel, bool> redeemOffer(ShopOfferModel offer) {
    if (redeemedOffers.contains(offer.id)) {
      return Tuple2(this, false);
    } else {
      return Tuple2(
        copyWith(redeemedOffers: [...redeemedOffers, offer.id]),
        true,
      );
    }
  }

  @override
  List<Object?> get props => [lushTokens, redeemedOffers];
}
