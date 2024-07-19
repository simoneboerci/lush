import 'package:cloud_firestore/cloud_firestore.dart';

enum ShopOfferType {
  magic,
  creative,
  basic,
}

class ShopOfferModel {
  final String id;
  final String label;
  final DateTime startDate;
  final DateTime? endDate;
  final double fullPrice;
  final double? discountedPrice;
  final ShopOfferType offerType;
  final int offerAmount;

  ShopOfferModel({
    required this.id,
    this.label = '',
    required this.startDate,
    this.endDate,
    this.fullPrice = 0.0,
    this.discountedPrice,
    required this.offerType,
    required this.offerAmount,
  });

  factory ShopOfferModel.fromMap(Map<String, dynamic> map) {
    return ShopOfferModel(
      id: map['offer_id'] ?? '',
      label: map['label'] ?? '',
      startDate: (map['start_date'] as Timestamp).toDate(),
      endDate: map['end_date'] != null
          ? (map['end_date'] as Timestamp).toDate()
          : null,
      fullPrice: (map['full_price'] as num).toDouble(),
      discountedPrice: map['discounted_price'] != null
          ? (map['discounted_price'] as num).toDouble()
          : null,
      offerType: _parseOfferType(map['offer_type']),
      offerAmount: (map['offer_amount'] as num).toInt(),
    );
  }

  static ShopOfferType _parseOfferType(String? type) {
    switch (type) {
      case 'magic':
        return ShopOfferType.magic;
      case 'creative':
        return ShopOfferType.creative;
      case 'basic':
        return ShopOfferType.basic;
      default:
        return ShopOfferType.basic;
    }
  }
}
