import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

abstract class UserRepository implements Repository<User, UserModel> {
  // Otteini l'utente in base all'id
  Future<Either<Failure, User>> getUserById(String id);
  // Ottieni una lista di utenti in base alla query
  Future<Either<Failure, List<User>>> getUsersByQuery(
    String parameter,
    String query,
  );

  // Inizia a creare l'oggetto utente quando si registra velocemente
  Future<Either<Failure, User>> createPartialUser(String username);

  // Completa la creazione dell'oggetto utente e salvalo nel databse
  Future<Either<Failure, User>> completeUserCreation(User user);

  // Salva i dati inseriti nel primo step di verifica utente
  Future<Either<Failure, User>> confirmFirstStepVerification({
    required String userId,
    required String name,
    required String surname,
    required DateTime birthDate,
    required String birthAddress,
  });

  // Salva i dati inseriti nel secondo step di verifica utente
  Future<Either<Failure, User>> confirmSecondStepVerification({
    required String userId,
    required String residenceAddress,
    required String email,
    required String phoneNumber,
  });

  // Salva i dati inseriti nel terzo step di verifica utente
  Future<Either<Failure, User>> confirmThirdStepVerification({
    required String userId,
    required String fiscalCode,
  });

  // Aggiorna l'utente e tutti i dati al suo interno
  Future<Either<Failure, User>> updateUser(User user);
  // Mantieni l'utente ma cancella tutti i dati al suo interno
  Future<Either<Failure, User>> cleanUser(String userId);
  // Elimina l'utente con tutti i dati al suo interno
  Future<Either<Failure, User>> deleteUser(String userId);
}
