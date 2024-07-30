import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lush_app/core/exceptions/auth_exceptions.dart';
import 'package:lush_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Riferimento all'oggetto di autenticazione di Firebase
  final FirebaseAuth _auth;
  // Riferimento all'oggeto di sign in per l'accesso con Google
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn;

  // Ottieni l'id dell'utente loggato
  @override
  String? get currentUserId => _auth.currentUser?.uid;

  // Effettua il login in anonimo
  @override
  Future<UserModel> loginAnonymously({required String username}) async {
    try {
      // Ottieni le credenziali dell'utente effettuando un login anonimo
      final userCredential = await _auth.signInAnonymously();

      // Assicurati che esista un utente con queste credenziali
      if (_auth.currentUser == null) {
        throw AuthLoginAnonymouslyException(
            'User with credential: $userCredential not found');
      }

      // Ritorna il modello dell'utente loggato
      return UserModel.fromFirebaseUser(_auth.currentUser!);
    } catch (e) {
      throw AuthLoginAnonymouslyException(
          'An error occurred while logging in the user anonymously with username $username. Error Details: $e');
    }
  }

  // Effettua la registrazione tramite email e password
  @override
  Future<UserModel> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Genera le credenziali dell'utente tramite email e password
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Se l'utente è stato registrato correttamente invia un'email di verifica
      await _auth.currentUser?.sendEmailVerification();

      // Assicurati che esista un utente con queste credenziali
      if (_auth.currentUser == null) {
        throw AuthRegistrationWithEmailAndPasswordException(
            'User with credential: $userCredential not found');
      }

      // Ritorna il modello dell'utente loggato
      return UserModel.fromFirebaseUser(_auth.currentUser!, password: password);
    } catch (e) {
      throw AuthRegistrationWithEmailAndPasswordException(
          'An error occurred while registering the user with email: $email and password: $password. Error Details: $e');
    }
  }

  // Effettua il login tramite email e password
  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // Ottieni le credenziali dell'utente tramite email e password
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Assicurati che esista un utente con queste credenziali
      if (_auth.currentUser == null) {
        throw AuthLoginWithEmailAndPasswordException(
            'User with credential: $userCredential not found');
      }

      // Ritorna il modello dell'utente loggato
      return UserModel.fromFirebaseUser(_auth.currentUser!);
    } catch (e) {
      throw AuthLoginWithEmailAndPasswordException(
          'An error occurred while logging in the user with email: $email and password: $password. Error Details: $e');
    }
  }

  // Effettua il login tramite Google
  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      // Ottieni l'account Google
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();

      // Assicurati che l'account Google esista
      if (googleAccount == null) {
        throw AuthLoginWithGoogleException(
            'No Google account found during the login process');
      }

      // Ottieni la chiave di autenticazione Google
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      // Genera le credenziali di accesso Google
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Ottieni le credenziali di accesso dell'utente tramite credenziali Google
      final userCredential = await _auth.signInWithCredential(googleCredential);

      // Assicurati che esista un utente con queste credenziali
      if (_auth.currentUser == null) {
        throw AuthLoginWithGoogleException(
            'User with credential: $userCredential not found');
      }

      // Ritorna il modello dell'utente loggato
      return UserModel.fromFirebaseUser(_auth.currentUser!);
    } catch (e) {
      throw AuthLoginWithGoogleException(
          'An error occurred while logging in the user with Google. Error Details: $e');
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
