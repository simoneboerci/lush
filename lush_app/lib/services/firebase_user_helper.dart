import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/user_chat_info_model.dart';
import 'package:lush_app/models/user_purchase_info_model.dart';
import 'package:lush_app/models/firebase_user_exception.dart';

// Interfaccia per FirebaseUserHelper
abstract class IFirebaseUserHelper {
  String? get currentUserUid;
  Future<UserModel?> getUserWithUid(String uid);
  Future<void> storeUserData(UserModel user);
  Stream<int> getTokensCountStreamFromCurrentUser();
  Future<List<UserModel>> getUsersByQuery(String query,
      {bool skipCurrentUser = true});
}

// Classe che gestisce la creazione, la manipolazione e la gestione degli utenti e dei loro parametri tramite firebase
class FirebaseUserHelper implements IFirebaseUserHelper {
  // Riferimento all'istanza di firebase
  final FirebaseFirestore _firestore;
  // Riferimento all'istanza di autenticazione di firebase
  final FirebaseAuth _auth;

  // Riferimento alla collezione di utenti
  static const String firebaseUsersCollectionLabel = 'users';

  // Costruttore
  FirebaseUserHelper({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // Ottieni l'id dell'utente corrente
  @override
  String? get currentUserUid => _auth.currentUser?.uid;

  // Ottieni l'utente tramite id
  @override
  Future<UserModel?> getUserWithUid(String uid) async {
    try {
      // Ottieni l'utente con l'id selezionato
      final userDoc = await _firestore
          .collection(firebaseUsersCollectionLabel)
          .doc(uid)
          .get();
      // Assicurati che l'utente esista e che contenga dei dati
      if (userDoc.exists && userDoc.data() != null) {
        // Ritorna l'utente selezionato
        return UserModel.fromMap(userDoc.data()!);
      }
    } catch (e) {
      throw FirebaseUserException(
          'Impossibile trovare un utente nel database: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }

  // Salva un nuovo utente nel database
  @override
  Future<void> storeUserData(UserModel user) async {
    try {
      // Crea un nuovo utente nel database
      await _firestore
          .collection(firebaseUsersCollectionLabel)
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      throw FirebaseUserException(
          'Errore durante il salvataggio dei dati utente nel database: $e');
    }
  }

  // Ottieni il numero di token correnti dell'utente corrente
  @override
  Stream<int> getTokensCountStreamFromCurrentUser() {
    // Ottieni i dati dell'utente nel database
    return _firestore
        .collection(firebaseUsersCollectionLabel)
        .doc(currentUserUid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      // Ottieni il riferimento all'oggetto che gestisce gli acquisti
      final purchaseInfo = data?[UserModel.purchaseInfoLabel];
      // Ottieni il rifertimento al numero di token posseduti
      final tokensValue = purchaseInfo?[UserPurchaseInfoField.lushTokens.name];

      // Restituisce tokensValue se è di tipo int, altrimenti -1
      return tokensValue is int ? tokensValue : -1;
    });
  }

  // Metodo per ottenere una lista di utenti registrati in base a una query di testo
  @override
  Future<List<UserModel>> getUsersByQuery(
    String query, {
    bool skipCurrentUser = true,
  }) async {
    try {
      // Ottieni la lista di utenti registrati che hanno un username simile alla query
      final snapshot = await _firestore
          .collection(firebaseUsersCollectionLabel)
          .where(
              '${UserModel.chatInfoLabel}.${UserChatInfoField.username.name}',
              isGreaterThanOrEqualTo: query)
          .where(
              '${UserModel.chatInfoLabel}.${UserChatInfoField.username.name}',
              isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Converti i documenti in UserModel
      List<UserModel> users =
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

      // Se skipCurrentUser è true, filtra l'utente corrente dalla lista
      if (skipCurrentUser && currentUserUid != null) {
        users = users.where((user) => user.id != currentUserUid).toList();
      }

      // Ritorna la lista filtrata di utenti
      return users;
    } catch (e) {
      throw FirebaseUserException(
          'Errore durante la ricerca query degli utenti: $e');
    }
  }
}
