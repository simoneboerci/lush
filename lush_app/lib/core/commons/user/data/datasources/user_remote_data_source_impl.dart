import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/core/exceptions/user_remote_exceptions.dart';
import 'package:lush_app/core/commons/user/data/datasources/user_remote_data_source.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Ottieni il riferimento al documento utente nel database partendo dall'id
  DocumentReference<Map<String, dynamic>> _getUserRef(String userId) {
    return _firestore.collection(FirebaseCollectionsLabels.users).doc(userId);
  }

  // Ottieni lo snapshot di un'utente del database partendo dall'id
  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserSnapshot(
      String userId) async {
    return await _firestore
        .collection(FirebaseCollectionsLabels.users)
        .doc(userId)
        .get();
  }

  // Ottieni un modello utente in base all'id
  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      // Ottieni lo snapshot dell'utente corrispondente all'id
      final userSnapshot = await _getUserSnapshot(userId);

      // Assicurati che l'utente esista e che contenga dei dati
      if (!userSnapshot.exists || userSnapshot.data() == null) {
        throw UserNotFoundException('User $userId not found');
      }

      // Ritorna il modello dell'utente partendo dallo snapshot
      return UserModel.fromMap(userSnapshot.data()!);
    } catch (e) {
      throw UserNotFoundException(
          'An error occurred while getting the user with id: $userId from the database');
    }
  }

  // Salva un nuovo utente nel database
  @override
  Future<UserModel> createUserData(UserModel userModel) async {
    try {
      // Ottieni lo snapshot dell'utente passato in base all'id
      final userSnapshot = await _getUserSnapshot(userModel.id);

      // Assicurati che l'utente passato non esista già nel database
      if (userSnapshot.exists || userSnapshot.data() != null) {
        throw SaveUserException(
            'The user ${userModel.id} already exists in the database');
      }

      // Crea un nuovo documento utente nel database
      await _firestore
          .collection(FirebaseCollectionsLabels.users)
          .doc(userModel.id)
          .set(userModel.toMap());

      // Ritorna il modello utente appena salvato
      return userModel;
    } catch (e) {
      throw SaveUserException(
          'An error occurred while saving the user: ${userModel.id}');
    }
  }

  // Aggiorna un utente nel database
  @override
  Future<UserModel> updateUserData(UserModel user) async {
    try {
      // Ottieni un riferimento al documento utente
      final usersRef = _getUserRef(user.id);

      // Aggiorna l'utente nel database con i nuovi dati
      await usersRef.update(user.toMap());

      // Ritorna l'utente aggiornato
      return user;
    } catch (e) {
      throw UpdateUserException(
          'An error occurred while updating the user: ${user.id}');
    }
  }

  // Elimina un utente dal database in base all'id
  @override
  Future<UserModel> deleteUserData(String userId) async {
    try {
      // Ottieni il riferimento al documento utente
      final userRef = _getUserRef(userId);

      // Ottieni lo snapshot dei dati utente
      final userSnapshot = await userRef.get();

      // Assicurati che l'utente esista e che contenga dei dati
      if (!userSnapshot.exists || userSnapshot.data() == null) {
        throw UserNotFoundException('User $userId not found');
      }

      // Cancella il docuemento
      await userRef.delete();

      // Ritorna il modello dell'utente eliminato
      return UserModel.fromMap(userSnapshot.data()!);
    } catch (e) {
      throw DeleteUserException(
          'An error occurred while deleting the user with id: $userId from the database');
    }
  }

  // Elimina di dati di un utente nel database in base all'id
  @override
  Future<UserModel> cleanUserData(String userId) async {
    try {
      // Ottieni il riferimento al documento utente
      final userRef = _getUserRef(userId);

      // Ottiei lo snapshot dei dati utente
      final userSnapshot = await userRef.get();

      // Assicurati che l'utente esista e che contenga dei dati
      if (!userSnapshot.exists || userSnapshot.data() == null) {
        throw UserNotFoundException('User $userId not found');
      }

      // Crea un modello di utente vuoto mantenendo l'id
      final updatedUserModel = UserModel.empty(userId);

      // Aggiorna il documento nel database
      await userRef.set(updatedUserModel.toMap());

      //Ritorna il modello di utente pulito
      return updatedUserModel;
    } catch (e) {
      throw CleanUserException(
          'An error occurred while cleaning the user data of the user: $userId');
    }
  }

  // Ottieni una lista di utente utilizzando una funzione di query su un parametro specifico
  @override
  Future<List<UserModel>> getUsersByQuery(
    String parameter,
    String query,
  ) async {
    try {
      // Ottieni uno snapshot degli utente che rientra nella query
      final snapshot = await _firestore
          .collection(FirebaseCollectionsLabels.users)
          .where(parameter, isGreaterThanOrEqualTo: query)
          .where(parameter, isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Crea una lista di user model partendo dallo snapshot degli utenti trovato
      List<UserModel> users =
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

      // ritorna la lista di modelli utente
      return users;
    } catch (e) {
      throw GetUsersByQueryException(
          'An error occurred while getting users by query: $query');
    }
  }

  @override
  Future<UserModel> confirmFirstStepVerification({
    required String userId,
    required String name,
    required String surname,
    required DateTime birthDate,
    required String birthAddress,
  }) async {
    try {
      // Ottieni un riferimento al documento utente
      final userRef = _getUserRef(userId);

      // Ottieni il modello utente selezionato
      final user = await getUserById(userId);

      // Crea un modello utente con i nuovi dati
      final updatedUser = user.copyWith(
        personalInfo: user.personalInfo.copyWith(
          name: name,
          surname: surname,
          birthDate: birthDate,
          birthAddress: birthAddress,
        ),
      );

      // Aggiorna i dati utente nel database
      userRef.update(updatedUser.toMap());

      // Ritorna l'utente aggiornato
      return updatedUser;
    } catch (e) {
      throw FirstStepVerificationException(e.toString());
    }
  }

  @override
  Future<UserModel> confirmSecondStepVerification({
    required String userId,
    required String residenceAddress,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      // Ottieni un riferimento al documento utente
      final userRef = _getUserRef(userId);

      // Ottieni il modello utente selezionato
      final user = await getUserById(userId);

      // Crea un modello utente con i nuovi dati
      final updatedUser = user.copyWith(
        personalInfo: user.personalInfo.copyWith(
          residenceAddress: residenceAddress,
        ),
        contactInfo: user.contactInfo.copyWith(
          email: email,
          phoneNumber: phoneNumber,
        ),
      );

      // Aggiorna i dati utente nel database
      userRef.update(updatedUser.toMap());

      // Ritorna l'utente aggiornato
      return updatedUser;
    } catch (e) {
      throw SecondStepVerificationException(e.toString());
    }
  }

  @override
  Future<UserModel> confirmThirdStepVerification({
    required String userId,
    required String fiscalCode,
  }) async {
    try {
      // Ottieni un riferimento al documento utente
      final userRef = _getUserRef(userId);

      // Ottieni il modello utente selezionato
      final user = await getUserById(userId);

      // Crea un modello utente con i nuovi dati
      final updatedUser = user.copyWith(
        personalInfo: user.personalInfo.copyWith(
          fiscalCode: fiscalCode,
        ),
      );

      // Aggiorna i dati utente nel database
      userRef.update(updatedUser.toMap());

      // Ritorna l'utente aggiornato
      return updatedUser;
    } catch (e) {
      throw SecondStepVerificationException(e.toString());
    }
  }
}
