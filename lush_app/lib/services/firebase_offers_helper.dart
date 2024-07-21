import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lush_app/models/firebase_offers_exception.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/shop_offer_model.dart';

// Interfaccia per FirebaseOffersHelper
abstract class IFirebaseOffersHelper {
  Stream<List<ShopOfferModel>> getCreditsOffersStream();
  Future<void> addOffer(ShopOfferModel offer);
  Future<void> updateOffer(ShopOfferModel offer);
  Future<void> deleteOffer(String offerId);
}

// Classe che gestisce le offerte e gli abbonamenti degli utenti tramite firebase
class FirebaseOffersHelper implements IFirebaseOffersHelper {
  // Riferimento all'istanza di firebase
  final FirebaseFirestore _firestore;

  // Riferimento alla collezzione delle offerte nel database
  static const String firebaseOffersCollectionLabel = 'offers';

  FirebaseOffersHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Ottieni la lista di offerte correnti dal database
  @override
  Stream<List<ShopOfferModel>> getCreditsOffersStream() async* {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    try {
      // Ottieni la collezione di offerte e ritorna una lista di offerte
      yield* _firestore
          .collection(firebaseOffersCollectionLabel)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ShopOfferModel.fromMap(doc.data()..['id'] = doc.id);
        }).toList();
      });
    } catch (e) {
      throw FirebaseOffersException('Error fetching credit offers: $e');
    }
  }

  @override
  Future<void> addOffer(ShopOfferModel offer) async {
    await FirebaseHelper().ensureInitialized();
    try {
      await _firestore
          .collection(firebaseOffersCollectionLabel)
          .add(offer.toMap());
    } catch (e) {
      throw FirebaseOffersException('Error adding offer: $e');
    }
  }

  @override
  Future<void> updateOffer(ShopOfferModel offer) async {
    await FirebaseHelper().ensureInitialized();

    try {
      await _firestore
          .collection(firebaseOffersCollectionLabel)
          .doc(offer.id)
          .update(offer.toMap());
    } catch (e) {
      throw FirebaseOffersException('Error updating offer: $e');
    }
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    await FirebaseHelper().ensureInitialized();

    try {
      await _firestore
          .collection(firebaseOffersCollectionLabel)
          .doc(offerId)
          .delete();
    } catch (e) {
      throw FirebaseOffersException('Error deleting offer: $e');
    }
  }
}
