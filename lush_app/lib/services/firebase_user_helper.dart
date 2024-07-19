import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lush_app/models/user_purchase_info_model.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/user_chat_info_model.dart';

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
    await FirebaseHelper.ensureInitialized();

    // Ottieni i dati dell'utente nel database
    yield* FirebaseFirestore.instance
        .collection(firebaseUsersCollectionLabel)
        .doc(getCurrentUserUid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      // Ottieni il riferimento all'oggetto che gestisce gli acquisti
      final purchaseInfo = data?[UserModel.purchaseInfoLabel];
      // Ottieni il rifertimento al numero di token posseduti dall'utente
      final tokensValue = purchaseInfo?[UserPurchaseInfoModel.lushTokensLabel];

      // Restituisce tokensValue se è di tipo int, altrimenti -1
      return tokensValue is int ? tokensValue : -1;
    });
  }

  // Metodo per ottenere una lista di utenti registrati in base a una query di testo
  Future<List<UserModel>> getUsersByQuery({
    required String query,
    bool skipCurrentUser = true,
  }) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();
    try {
      // Ottieni la lista di utenti registrati che hanno un username simile alla query
      final snapshot = await FirebaseFirestore.instance
          .collection(firebaseUsersCollectionLabel)
          .where(
              '${UserModel.chatInfoLabel}.${UserChatInfoModel.usernameLabel}',
              isGreaterThanOrEqualTo: query)
          .where(
              '${UserModel.chatInfoLabel}.${UserChatInfoModel.usernameLabel}',
              isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Converti i documenti in UserModel
      List<UserModel> users =
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

      // Se skipCurrentUser è true, filtra l'utente corrente dalla lista
      if (skipCurrentUser && getCurrentUserUid != null) {
        users = users.where((user) => user.id != getCurrentUserUid).toList();
      }

      // Ritorna la lista filtrata di utenti
      return users;
    } catch (e) {
      print('Errore durante la ricerca query degli utenti: $e');
    }
    // Se l'operazione non va a buon fine ritorna una lista vuota
    return const [];
  }
}
