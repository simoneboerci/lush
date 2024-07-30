import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

// Interfaccia di base per la repository di autenticazione
abstract interface class AuthRepository implements Repository<User, UserModel> {
  //Ottieni l'id dell'utente loggato
  Either<Failure, String> getCurrentUserId();

  // Effettua il login di un utente in forma anonima
  Future<Either<Failure, User>> loginAnonymously({
    required String username,
  });

  // Registra un nuovo utente con email e password
  Future<Either<Failure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Effettua il login di un utente tramite email e password
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Effettua il login di un utente tramite google
  Future<Either<Failure, User>> loginWithGoogle();

  // Effettua il logout dall'account
  Future<Either<Failure, void>> logout();
}
