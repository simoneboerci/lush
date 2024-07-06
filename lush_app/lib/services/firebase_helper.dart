import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lush_app/firebase_options.dart';
import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/direct_message.dart';

import 'package:lush_app/models/lush_credits_offer.dart';

import 'package:lush_app/models/lush_user.dart';

class FirebaseHelper {
  static const String firebaseUsersCollectionLabel = 'users';
  static const String firebaseOffersCollectionLabel = 'offers';
  static const String firebaseChatsCollectionLabel = 'chats';
  static const String firebaseMessagesCollectionLabel = 'messages';

  static String getCurrentUserUid = FirebaseAuth.instance.currentUser!.uid;

  static bool _isInitialized = false;

  static Future<void> ensureInitialized() async {
    if (!_isInitialized) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _isInitialized = true;
    }
  }

  static Future<LushUser?> getUserWithUid(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(firebaseUsersCollectionLabel)
              .doc(uid)
              .get();
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        return LushUser.fromMap(documentSnapshot.data()!);
      }
    } catch (e) {
      print('Impossibile trovare un utente nel database: $e');
    }

    return null;
  }

  static Future<LushUser?> loginAnonimously(String username) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      return LushUser(userId: userCredential.user!.uid, username: username);
    } catch (e) {
      print('Errore durante il login anonimo: $e');
    }

    return null;
  }

  static Future<LushUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return LushUser(
          userId: userCredential.user!.uid, email: email, password: password);
    } catch (e) {
      print('Errore durante il login con email e password: $e');
    }

    return null;
  }

  static Future<LushUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      return LushUser(
          userId: userCredential.user!.uid, email: email, password: password);
    } catch (e) {
      print('Errore durante la registrazione con email e password: $e');
    }

    return null;
  }

  static Future<LushUser?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return LushUser(
        userId: userCredential.user!.uid,
        username: userCredential.user!.displayName,
        email: userCredential.user!.email,
      );
    } catch (e) {
      print('Errore durante il login con Google: $e');
    }

    return null;
  }

  static Future<void> storeUserData(LushUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection(firebaseUsersCollectionLabel)
          .doc(user.userId)
          .set(user.toMap());
    } catch (e) {
      print('Errore durante il salvataggio dei dati utente nel database: $e');
    }
  }

  static Stream<List<LushCreditsOffer>> getCreditsOffersStream() async* {
    await ensureInitialized();

    yield* FirebaseFirestore.instance
        .collection(firebaseOffersCollectionLabel)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return LushCreditsOffer.fromMap(doc.data()..['id'] = doc.id);
      }).toList();
    });
  }

  static Stream<int> getTokensCountStreamFromCurrentUser() async* {
    await ensureInitialized();

    yield* FirebaseFirestore.instance
        .collection(firebaseUsersCollectionLabel)
        .doc(getCurrentUserUid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()!['lush_tokens_count'] as int;
    });
  }

  static Future<void> sendMessage(DirectMessage message) async {
    final messageRef = FirebaseFirestore.instance
        .collection(firebaseMessagesCollectionLabel)
        .doc();
    final messageData = message.toMap();
    messageData['id'] = messageRef.id;
    messageData['is_delivered'] = false;
    messageData['is_read'] = false;

    await messageRef.set(messageData);

    // Aggiorna il campo isDelivered dopo che il messaggio è stato inviato con successo
    await messageRef.update({'is_delivered': true});
  }

  static Future<void> markMessageAsRead(String messageId) async {
    await FirebaseFirestore.instance
        .collection(firebaseMessagesCollectionLabel)
        .doc(messageId)
        .update({'is_read': true});
  }

  static Stream<List<DirectMessage>> getMessagesFromChat(String chatId) async* {
    await ensureInitialized();

    yield* FirebaseFirestore.instance
        .collection(firebaseMessagesCollectionLabel)
        .where('chat_id', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DirectMessage.fromMap(doc.data()))
            .toList());
  }

  static Future<void> createChat(String user1Id, String user2Id) async {
    String chatId = user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_$user2Id'
        : '${user2Id}_$user1Id';

    await FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .doc(chatId)
        .set({
      'participant_ids': [user1Id, user2Id],
      'last_message': '',
      'last_message_timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<ChatModel>> getUserChats(String userId) async* {
    await ensureInitialized();

    yield* FirebaseFirestore.instance
        .collection(firebaseChatsCollectionLabel)
        .where('participant_ids', arrayContains: userId)
        .orderBy('last_message_timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList());
  }
}
