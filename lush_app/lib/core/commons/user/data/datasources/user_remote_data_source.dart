import 'package:lush_app/core/commons/user/data/models/user_model.dart';

abstract interface class UserRemoteDataSource {
  // Ottieni l'utente partendo dall'id
  Future<UserModel> getUserById(String id);

  // Crea un nuovo documento utente nel database
  Future<UserModel> createUserData(UserModel user);
  // Aggiorna un documento utente nel database
  Future<UserModel> updateUserData(UserModel user);
  // Cancella i dati di un documento utente nel database ma mantieni il documento
  Future<UserModel> cleanUserData(String userId);
  // Cancella un documento utente nel database
  Future<UserModel> deleteUserData(String userId);

  // Ottieni una lista di utenti utilizzando una funzione di query su una variabile specifica
  Future<List<UserModel>> getUsersByQuery(String parameter, String query);

  // Salva i dati inseriti nel primo step di verifica utente
  Future<UserModel> confirmFirstStepVerification({
    required String userId,
    required String name,
    required String surname,
    required DateTime birthDate,
    required String birthAddress,
  });

  // Salva i dati inseriti nel secondo step di verifica utente
  Future<UserModel> confirmSecondStepVerification({
    required String userId,
    required String residenceAddress,
    required String email,
    required String phoneNumber,
  });

  // Salva i dati inseriti nel terzo step di verifica utente
  Future<UserModel> confirmThirdStepVerification({
    required String userId,
    required String fiscalCode,
  });
}
