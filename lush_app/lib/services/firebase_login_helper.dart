import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/user_chat_info_model.dart';
import 'package:lush_app/models/user_contact_info_model.dart';
import 'package:lush_app/models/user_personal_info_model.dart';
import 'package:lush_app/models/user_purchase_info_model.dart';
import 'package:lush_app/models/firebase_login_exception.dart';

// Interfaccia per FirebaseLoginHelper
abstract class IFirebaseLoginHelper {
  Future<UserModel?> loginWithEmailAndPassword(String email, String password);
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password);
  Future<UserModel?> loginWithGoogle();
  Future<UserModel?> loginAnonymously(String username);
}

// Classe che gestisce le operazioni di login-logout e registrazione utente tramite firebase
class FirebaseLoginHelper implements IFirebaseLoginHelper {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  FirebaseLoginHelper({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Effettua il login tramite email e password
  @override
  Future<UserModel?> loginWithEmailAndPassword(
      String email, String password) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    try {
      // Ottieni le credenziali dell'utente tramite email e password
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Ritorna l'utente loggato
      return _createUserModelFromCredential(userCredential,
          email: email, password: password);
    } catch (e) {
      throw FirebaseLoginException(
          'Errore durante il login con email e password: $e');
    }
  }

  // Registra un utente con email e password
  @override
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    try {
      // Genera le credenziali dell'utente tramite email e password
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Se l'utente è stato registrato correttamente invia un'email di verifica delle credenziali
      await _auth.currentUser?.sendEmailVerification();

      // Ritorna l'utente loggato
      return _createUserModelFromCredential(userCredential,
          email: email, password: password);
    } catch (e) {
      throw FirebaseLoginException(
          'Errore durante la registrazione con email e password: $e');
    }
  }

  // Effettua il login tramite Google
  @override
  Future<UserModel?> loginWithGoogle() async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    try {
      // Crea un utente google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Se l'operazione non va a buon fine ritorna null
      if (googleUser == null) return null;

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

      // Ritorna l'utente loggato
      return _createUserModelFromCredential(userCredential);
    } catch (e) {
      throw FirebaseLoginException('Errore durante il login con Google: $e');
    }
  }

  // Esegui il login senza credenziali
  @override
  Future<UserModel?> loginAnonymously(String username) async {
    // Assicura che firebase sia inizializzato
    await FirebaseHelper().ensureInitialized();

    try {
      // Effettua il login anonimo nel database
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      // Ritorna l'utente loggato
      return _createUserModelFromCredential(userCredential, username: username);
    } catch (e) {
      throw FirebaseLoginException('Errore durante il login anonimo: $e');
    }
  }

  // Crea un oggetto utente a partire dalle credenziali di accesso
  UserModel? _createUserModelFromCredential(
    UserCredential credential, {
    String? email,
    String? password,
    String? username,
  }) {
    // Assicurati che le credenziali siano valide
    if (credential.user == null) return null;

    // Ritorna l'oggetto utente
    return UserModel(
      id: credential.user!.uid,
      contactInfo: UserContactInfoModel(
        email: email ?? credential.user!.email,
        password: password,
      ),
      personalInfo: const UserPersonalInfoModel(),
      chatInfo: UserChatInfoModel.online().copyWith(
        username: username ?? credential.user!.displayName,
      ),
      purchaseInfo: const UserPurchaseInfoModel(),
    );
  }
}
