import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/user_model.dart';

// Classe che gestisce la creazione, la manipolazione e la gestione degli utenti e dei loro parametri tramite firebase
class FirebaseUserHelper {
  // Riferimento alla collezione di utenti
  static const String firebaseUsersCollectionLabel = 'users';

  // Ottieni l'id dell'utente corrente
  String? getCurrentUserUid = FirebaseAuth.instance.currentUser?.uid;

  // Ottieni l'utente tramite id
  Future<UserModel?> getUserWithUid(String uid) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Ottieni l'utente con l'id selezionato
      final usersRef = await FirebaseFirestore.instance
          .collection(firebaseUsersCollectionLabel)
          .doc(uid)
          .get();
      // Assicurati che l'utente esista e che contenga dei dati
      if (usersRef.exists && usersRef.data() != null) {
        // Ritorna l'utente selezionato
        return UserModel.fromMap(usersRef.data()!);
      }
    } catch (e) {
      print('Impossibile trovare un utente nel database: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }

  // Salva un nuovo utente nel database
  Future<void> storeUserData(UserModel user) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Crea un nuovo utente nel database
      await FirebaseFirestore.instance
          .collection(firebaseUsersCollectionLabel)
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      print('Errore durante il salvataggio dei dati utente nel database: $e');
    }
  }

  // Ottieni il numero di token correnti dell'utente corrente
  Stream<int> getTokensCountStreamFromCurrentUser() async* {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    // Ottieni l'utente corrente
    yield* FirebaseFirestore.instance
        .collection(firebaseUsersCollectionLabel)
        .doc(getCurrentUserUid)
        .snapshots()
        .map((snapshot) {
      // Verifica che l'utente esista e che contenga dei dati
      if (snapshot.exists && snapshot.data() != null) {
        // Ritorna il numero di token che l'utente possiede
        return snapshot.data()!['lush_tokens_count'] as int;
      }

      // Se l'operazione non va a buon fine ritorna un numero di token negativo
      return -1;
    });
  }
}
