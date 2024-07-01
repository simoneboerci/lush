import 'package:cloud_firestore/cloud_firestore.dart';

enum CreditsOfferType {
  magic,
  creative,
  basic,
}

class LushCreditsOffer {
  final String id;
  final String label;
  final DateTime startDate;
  final DateTime? endDate;
  final double fullPrice;
  final double? discountedPrice;
  final CreditsOfferType offerType;

  LushCreditsOffer({
    required this.id,
    this.label = '',
    required this.startDate,
    this.endDate,
    this.fullPrice = 0.0,
    this.discountedPrice,
    required this.offerType,
  });

  factory LushCreditsOffer.fromMap(Map<String, dynamic> map) {
    return LushCreditsOffer(
      id: map['id'] ?? '',
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
    );
  }

  static CreditsOfferType _parseOfferType(String? type) {
    switch (type) {
      case 'magic':
        return CreditsOfferType.magic;
      case 'creative':
        return CreditsOfferType.creative;
      case 'basic':
        return CreditsOfferType.basic;
      default:
        return CreditsOfferType.basic; // o gestisci diversamente
    }
  }
}
