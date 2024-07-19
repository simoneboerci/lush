import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/shop_offer_model.dart';

// Classe che gestisce le offerte e gli abbonamenti degli utenti tramite firebase
class FirebaseOffersHelper {
  // Riferimento alla collezzione delle offerte nel database
  static const String firebaseOffersCollectionLabel = 'offers';

  // Ottieni la lista di offerte correnti dal database
  Stream<List<ShopOfferModel>> getCreditsOffersStream() async* {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    // Ottieni la collezione di offerte e ritorna una lista di offerte
    yield* FirebaseFirestore.instance
        .collection(firebaseOffersCollectionLabel)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShopOfferModel.fromMap(doc.data()..['id'] = doc.id);
      }).toList();
    });
  }
}
