import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum ShopOfferType {
  magic,
  creative,
  basic,
}

enum ShopOfferField {
  id,
  label,
  startDate,
  endDate,
  fullPrice,
  discountedPrice,
  offerType,
  offerAmount,
}

@immutable
class ShopOfferModel extends Equatable {
  final String id;
  final String label;
  final DateTime startDate;
  final DateTime? endDate;
  final double fullPrice;
  final double? discountedPrice;
  final ShopOfferType offerType;
  final int offerAmount;

  const ShopOfferModel({
    required this.id,
    this.label = '',
    required this.startDate,
    this.endDate,
    this.fullPrice = 0.0,
    this.discountedPrice,
    required this.offerType,
    required this.offerAmount,
  })  : assert(fullPrice >= 0, 'Full price must be non-negative'),
        assert(
            discountedPrice == null ||
                (discountedPrice >= 0 && discountedPrice < fullPrice),
            'Discounted price must be non-negative and less than full price'),
        assert(offerAmount > 0, 'Offer amount must be positive');

  factory ShopOfferModel.fromMap(Map<String, dynamic> map) {
    return ShopOfferModel(
      id: map[ShopOfferField.id.name] as String? ?? '',
      label: map[ShopOfferField.label.name] as String? ?? '',
      startDate: (map[ShopOfferField.startDate.name] as Timestamp).toDate(),
      endDate: map[ShopOfferField.endDate.name] != null
          ? (map[ShopOfferField.endDate.name] as Timestamp).toDate()
          : null,
      fullPrice: (map[ShopOfferField.fullPrice.name] as num).toDouble(),
      discountedPrice: map[ShopOfferField.discountedPrice.name] != null
          ? (map[ShopOfferField.discountedPrice.name] as num).toDouble()
          : null,
      offerType: ShopOfferType.values.firstWhere(
        (e) => e.name == map[ShopOfferField.offerType.name] as String,
        orElse: () => ShopOfferType.basic,
      ),
      offerAmount: (map[ShopOfferField.offerAmount.name] as num).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ShopOfferField.id.name: id,
      ShopOfferField.label.name: label,
      ShopOfferField.startDate.name: Timestamp.fromDate(startDate),
      ShopOfferField.endDate.name:
          endDate != null ? Timestamp.fromDate(endDate!) : null,
      ShopOfferField.fullPrice.name: fullPrice,
      ShopOfferField.discountedPrice.name: discountedPrice,
      ShopOfferField.offerType.name: offerType,
      ShopOfferField.offerAmount.name: offerAmount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        label,
        startDate,
        endDate,
        fullPrice,
        discountedPrice,
        offerType,
        offerAmount
      ];
}
