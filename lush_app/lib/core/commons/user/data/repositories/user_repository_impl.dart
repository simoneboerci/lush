import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_chat_info.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_contact_info.dart';
import 'package:lush_app/core/commons/user/domain/entities/user_info/user_personal_info.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/exceptions/user_remote_exceptions.dart';
import 'package:lush_app/core/commons/user/data/datasources/user_remote_data_source.dart';
import 'package:lush_app/core/commons/user/data/models/user_model.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_chat_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_contact_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_personal_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  final UserPersonalInfoRepository personalInfoRepository;
  final UserChatInfoRepository chatInfoRepository;
  final UserContactInfoRepository contactInfoRepository;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.personalInfoRepository,
    required this.chatInfoRepository,
    required this.contactInfoRepository,
  });

  @override
  User toEntity(UserModel model) {
    return User(
      id: model.id,
      personalInfo: personalInfoRepository.toEntity(model.personalInfo),
      contactInfo: contactInfoRepository.toEntity(model.contactInfo),
      chatInfo: chatInfoRepository.toEntity(model.chatInfo),
    );
  }

  @override
  UserModel toModel(User entity) {
    return UserModel(
      id: entity.id,
      personalInfo: personalInfoRepository.toModel(entity.personalInfo),
      contactInfo: contactInfoRepository.toModel(entity.contactInfo),
      chatInfo: chatInfoRepository.toModel(entity.chatInfo),
    );
  }

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    return await _getUser(
        () async => await userRemoteDataSource.getUserById(id));
  }

  @override
  Future<Either<Failure, List<User>>> getUsersByQuery(
      String parameter, String query) async {
    try {
      final userModels =
          await userRemoteDataSource.getUsersByQuery(parameter, query);

      final users = userModels.map((userModel) => toEntity(userModel)).toList();

      return right(users);
    } on UserRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> createPartialUser(String username) async {
    // Assicurati che l'username non sia vuoto
    // ? Potenzialmente inserire questo metodo nel data source e assicurasi che non si possa inserire uno username doppio
    if (username.isEmpty) {
      return left(const Failure(
          message: 'An error occurred while creating the partial user'));
    }

    // Crea l'utente parziale
    final User user = User(
      id: '',
      personalInfo: const UserPersonalInfo(),
      contactInfo: const UserContactInfo(),
      chatInfo: UserChatInfo(
        lastSeen: DateTime.now(),
        isOnline: true,
        username: username,
      ),
    );

    // Ritorna l'utente parziale
    return right(user);
  }

  @override
  Future<Either<Failure, User>> completeUserCreation(User user) async {
    return await _getUser(
        () async => await userRemoteDataSource.createUserData(toModel(user)));
  }

  @override
  Future<Either<Failure, User>> confirmFirstStepVerification({
    required String userId,
    required String name,
    required String surname,
    required DateTime birthDate,
    required String birthAddress,
  }) async {
    return await _getUser(
      () async => await userRemoteDataSource.confirmFirstStepVerification(
        userId: userId,
        name: name,
        surname: surname,
        birthDate: birthDate,
        birthAddress: birthAddress,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> confirmSecondStepVerification({
    required String userId,
    required String residenceAddress,
    required String email,
    required String phoneNumber,
  }) async {
    return await _getUser(
      () async => await userRemoteDataSource.confirmSecondStepVerification(
        userId: userId,
        residenceAddress: residenceAddress,
        email: email,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> confirmThirdStepVerification({
    required String userId,
    required String fiscalCode,
  }) async {
    return await _getUser(
      () async => await userRemoteDataSource.confirmThirdStepVerification(
        userId: userId,
        fiscalCode: fiscalCode,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    return await _getUser(
        () async => await userRemoteDataSource.updateUserData(toModel(user)));
  }

  @override
  Future<Either<Failure, User>> cleanUser(String userId) async {
    return await _getUser(
        () async => await userRemoteDataSource.cleanUserData(userId));
  }

  @override
  Future<Either<Failure, User>> deleteUser(String userId) async {
    return await _getUser(
        () async => await userRemoteDataSource.deleteUserData(userId));
  }

  Future<Either<Failure, User>> _getUser(
      Future<UserModel> Function() function) async {
    try {
      final userModel = await function();
      return right(toEntity(userModel));
    } on UserRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
