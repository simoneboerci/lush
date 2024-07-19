import 'package:firebase_core/firebase_core.dart';
import 'package:lush_app/firebase_options.dart';

import 'package:lush_app/services/firebase_chats_helper.dart';
import 'package:lush_app/services/firebase_login_helper.dart';
import 'package:lush_app/services/firebase_offers_helper.dart';
import 'package:lush_app/services/firebase_user_helper.dart';

// Classe che conserva i moduli di gestione del database firebase
class FirebaseHelper {
  // Variabile di inizializzazione del database
  static bool _isInitialized = false;

  // Modulo di gestione utente tramite firebase
  static FirebaseUserHelper userHelper = FirebaseUserHelper();
  // Modulo di gestione login, logout, registrazione utente tramite firebase
  static FirebaseLoginHelper loginHelper = FirebaseLoginHelper();
  // Modulo di gestione chat e messaggi tra utenti tramite firebase
  static FirebaseChatsHelper chatsHelper = FirebaseChatsHelper();
  // modulo di gestione offerte e abbonamenti tramite firebase
  static FirebaseOffersHelper offersHelper = FirebaseOffersHelper();

  // Metodo che assicura la corretta inizializzazione del database
  static Future<void> ensureInitialized() async {
    // Verifica che il database non sia già stato inizializzato
    if (!_isInitialized) {
      // Inizializza il database
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Aggiorna la variabile di inizializzazione
      _isInitialized = true;
    }
  }
}
