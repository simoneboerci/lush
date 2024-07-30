import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

@immutable
class UserPurchaseInfo extends Equatable {
  final int lushTokens;
  final List<String> redeemedOffers;

  const UserPurchaseInfo({
    this.lushTokens = 0,
    this.redeemedOffers = const [],
  });

  @override
  List<Object?> get props => [lushTokens, redeemedOffers];
}
