import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/user_chat_info_model.dart';
import 'package:lush_app/models/user_contact_info_model.dart';
import 'package:lush_app/models/user_personal_info_model.dart';
import 'package:lush_app/models/user_purchase_info_model.dart';

// Classe che gestisce le operazioni di login-logout e registrazione utente tramite firebase
class FirebaseLoginHelper {
  // Effettua il login tramite email e password
  Future<UserModel?> loginWithEmailAndPassword(
      String email, String password) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Ottieni le credenziali dell'utente tramite email e password
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Se l'utente con quelle credenziali esiste
      if (userCredential.user != null) {
        // Ritorna l'utente con quelle credenziali
        return UserModel(
          id: userCredential.user!.uid,
          contactInfo:
              UserContactInfoModel.fromEmailAndPassword(email, password),
          personalInfo: UserPersonalInfoModel(),
          chatInfo: UserChatInfoModel.online(),
          purchaseInfo: UserPurchaseInfoModel(),
        );
      }
    } catch (e) {
      print('Errore durante il login con email e password: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }

  // Registra un utente con email e password
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Genera le credenziali dell'utente tramite email e password
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Se l'utente è stato registrato correttamente invia un'email di verifica delle credenziali
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      // Se l'utente con quelle credenziali esiste
      if (userCredential.user != null) {
        // Ritorna l'utente con quelle credenziali
        return UserModel(
          id: userCredential.user!.uid,
          contactInfo:
              UserContactInfoModel.fromEmailAndPassword(email, password),
          chatInfo: UserChatInfoModel.online(),
          personalInfo: UserPersonalInfoModel(),
          purchaseInfo: UserPurchaseInfoModel(),
        );
      }
    } catch (e) {
      print('Errore durante la registrazione con email e password: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }

  // Effettua il login tramite Google
  Future<UserModel?> loginWithGoogle() async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Crea un utente google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Se l'operazione non va a buon fine ritorna null
      if (googleUser == null) {
        return null;
      }

      // Otteni l'oggetto di autenticazione google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Genera le credenziali google tramite l'oggetto di autenticazione
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Genera le credenziali dell'utente sul database tramite le credenziali google
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Se l'utente è stato registrato correttamente
      if (userCredential.user != null) {
        // Ritorna l'utente
        return UserModel(
          id: userCredential.user!.uid,
          chatInfo: UserChatInfoModel.online()
              .copyWith(username: userCredential.user!.displayName),
          purchaseInfo: UserPurchaseInfoModel(),
          contactInfo: UserContactInfoModel(email: userCredential.user!.email),
          personalInfo: UserPersonalInfoModel(),
        );
      }
    } catch (e) {
      print('Errore durante il login con Google: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }

  // Esegui il login senza credenziali
  Future<UserModel?> loginAnonimously(String username) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper.ensureInitialized();

    try {
      // Effettua il login anonimo nel database
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      // Se la registrazione è stata effettuata correttamente
      if (userCredential.user != null) {
        // Ritorna l'utente creato
        return UserModel(
          id: userCredential.user!.uid,
          chatInfo: UserChatInfoModel.online().copyWith(username: username),
          contactInfo: UserContactInfoModel(),
          personalInfo: UserPersonalInfoModel(),
          purchaseInfo: UserPurchaseInfoModel(),
        );
      }
    } catch (e) {
      print('Errore durante il login anonimo: $e');
    }

    // Se l'operazione non va a buon fine ritorna null
    return null;
  }
}
