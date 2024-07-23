import 'package:firebase_core/firebase_core.dart';
import 'package:lush_app/firebase_options.dart';

import 'package:lush_app/services/firebase_chats_helper.dart';
import 'package:lush_app/services/firebase_login_helper.dart';
import 'package:lush_app/services/firebase_offers_helper.dart';
import 'package:lush_app/services/firebase_user_helper.dart';

// Interfaccia per FirebaseHelper
abstract class IFirebaseHelper {
  IFirebaseUserHelper get userHelper;
  IFirebaseLoginHelper get loginHelper;
  IFirebaseChatsHelper get chatsHelper;
  IFirebaseOffersHelper get offersHelper;
  Future<void> ensureInitialized();
}

// Classe che conserva i moduli di gestione del database firebase
class FirebaseHelper implements IFirebaseHelper {
  // Singleton
  static final FirebaseHelper _instance = FirebaseHelper._internal();
  factory FirebaseHelper() => _instance;
  FirebaseHelper._internal();

  // Variabile di inizializzazione del database
  bool _isInitialized = false;

  // Moduli di gestione del database
  late final IFirebaseUserHelper _userHelper;
  late final IFirebaseLoginHelper _loginHelper;
  late final IFirebaseChatsHelper _chatsHelper;
  late final IFirebaseOffersHelper _offersHelper;

  // Getters dei moduli di gestione
  @override
  IFirebaseUserHelper get userHelper => _userHelper;
  @override
  IFirebaseLoginHelper get loginHelper => _loginHelper;
  @override
  IFirebaseChatsHelper get chatsHelper => _chatsHelper;
  @override
  IFirebaseOffersHelper get offersHelper => _offersHelper;

  // Metodo che assicura la corretta inizializzazione del database
  @override
  Future<void> ensureInitialized() async {
    // Verifica che il database non sia già stato inizializzato
    if (!_isInitialized) {
      // Inizializza il database
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Aggiorna la variabile di inizializzazione
      _isInitialized = true;

      // Inizializza i moduli di gestione
      _userHelper = FirebaseUserHelper();
      _loginHelper = FirebaseLoginHelper();
      _chatsHelper = FirebaseChatsHelper();
      _offersHelper = FirebaseOffersHelper();
    }
  }
}
