import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lush_app/core/commons/user/domain/usecases/complete_user_creation_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_first_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_second_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_third_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/create_partial_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/get_users_by_query_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/update_user_use_case.dart';
import 'package:lush_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lush_app/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:lush_app/core/commons/user/data/datasources/user_remote_data_source.dart';
import 'package:lush_app/core/commons/user/data/datasources/user_remote_data_source_impl.dart';
import 'package:lush_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lush_app/core/commons/user/data/repositories/user_chat_info_repository_impl.dart';
import 'package:lush_app/core/commons/user/data/repositories/user_contact_info_repository_impl.dart';
import 'package:lush_app/core/commons/user/data/repositories/user_personal_info_repository_impl.dart';
import 'package:lush_app/core/commons/user/data/repositories/user_repository_impl.dart';
import 'package:lush_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_chat_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_contact_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_personal_info_repository.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';
import 'package:lush_app/features/auth/domain/usecases/get_current_user_id_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_anonymously_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_with_email_and_password_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/register_with_email_and_password_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/clean_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/delete_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/get_user_by_id_use_case.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => GoogleSignIn());

  _initUserDependencies();
  _initAuthDependencies();
}

void _initUserDependencies() {
  //Data sources
  serviceLocator
    ..registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(firestore: serviceLocator()),
    )

    // Repositories

    ..registerFactory<UserPersonalInfoRepository>(
        () => UserPersonalInfoRepositoryImpl())
    ..registerFactory<UserChatInfoRepository>(
        () => UserChatInfoRepositoryImpl())
    ..registerFactory<UserContactInfoRepository>(
        () => UserContactInfoRepositoryImpl())
    ..registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource: serviceLocator(),
        personalInfoRepository: serviceLocator(),
        chatInfoRepository: serviceLocator(),
        contactInfoRepository: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory(() => GetUserByIdUseCase(serviceLocator()))
    ..registerFactory(() => GetUsersByQueryUseCase(serviceLocator()))
    ..registerFactory(() => CreatePartialUserUseCase(serviceLocator()))
    ..registerFactory(() => CompleteUserCreationUseCase(serviceLocator()))
    ..registerFactory(
        () => ConfirmFirstStepVerificationUseCase(serviceLocator()))
    ..registerFactory(
        () => ConfirmSecondStepVerificationUseCase(serviceLocator()))
    ..registerFactory(
        () => ConfirmThirdStepVerificationUseCase(serviceLocator()))
    ..registerFactory(() => CleanUserUseCase(serviceLocator()))
    ..registerFactory(() => UpdateUserUseCase(serviceLocator()))
    ..registerFactory(() => DeleteUserUseCase(serviceLocator()))

    // Blocs
    ..registerLazySingleton(
      () => UserBloc(
        getUserByIdUseCase: serviceLocator(),
        getUsersByQueryUseCase: serviceLocator(),
        createPartialUserUseCase: serviceLocator(),
        completeUserCreationUseCase: serviceLocator(),
        confirmFirstStepVerificationUseCase: serviceLocator(),
        confirmSecondStepVerificationUseCase: serviceLocator(),
        confirmThirdStepVerificationUseCase: serviceLocator(),
        updateUserUseCase: serviceLocator(),
        cleanUserUseCase: serviceLocator(),
        deleteUserUseCase: serviceLocator(),
      ),
    );
}

void _initAuthDependencies() {
  // Data sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        auth: serviceLocator(),
        googleSignIn: serviceLocator(),
      ),
    )

    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          userRepository: serviceLocator()),
    )

    // Usecases
    ..registerFactory(() => GetCurrentUserIdUseCase(serviceLocator()))
    ..registerFactory(
        () => RegisterWithEmailAndPasswordUseCase(serviceLocator()))
    ..registerFactory(() => LoginWithEmailAndPasswordUseCase(serviceLocator()))
    ..registerFactory(() => LoginWithGoogleUseCase(serviceLocator()))
    ..registerFactory(() => LoginAnonymouslyUseCase(serviceLocator()))

    // Blocs
    ..registerLazySingleton(
      () => AuthBloc(
        getCurrentUserIdUserCase: serviceLocator(),
        registerWithEmailAndPasswordUseCase: serviceLocator(),
        loginWithEmailAndPasswordUseCase: serviceLocator(),
        loginWithGoogleUseCase: serviceLocator(),
        loginAnonymouslyUseCase: serviceLocator(),
      ),
    );
}
