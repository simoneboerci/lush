import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lush_app/firebase_options.dart';

import 'package:lush_app/models/lush_user.dart';

class FirebaseHelper {
  static const String firebaseUserCollectionLabel = 'users';

  static String getCurrentUserUid = FirebaseAuth.instance.currentUser!.uid;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<LushUser?> getUserWithUid(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(firebaseUserCollectionLabel)
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
          .collection(firebaseUserCollectionLabel)
          .doc(user.userId)
          .set(user.toMap());
    } catch (e) {
      print('Errore durante il salvataggio dei dati utente nel database: $e');
    }
  }
}
