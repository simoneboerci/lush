import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/domain/params/clean_user_params.dart';
import 'package:lush_app/core/commons/user/domain/params/complete_user_creation_params.dart';
import 'package:lush_app/core/commons/user/domain/params/create_partial_user_params.dart';
import 'package:lush_app/core/commons/user/domain/params/delete_user_params.dart';
import 'package:lush_app/core/commons/user/domain/params/first_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/params/get_user_by_id_params.dart';
import 'package:lush_app/core/commons/user/domain/params/get_users_by_query_params.dart';
import 'package:lush_app/core/commons/user/domain/params/second_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/params/third_step_verification_params.dart';
import 'package:lush_app/core/commons/user/domain/params/update_user_params.dart';
import 'package:lush_app/core/commons/user/domain/usecases/clean_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/complete_user_creation_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_first_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_second_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/confirm_third_step_verification_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/create_partial_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/delete_user_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/get_user_by_id_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/get_users_by_query_use_case.dart';
import 'package:lush_app/core/commons/user/domain/usecases/update_user_use_case.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_events.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUseCase _getUserByIdUseCase;
  final GetUsersByQueryUseCase _getUsersByQueryUseCase;
  final CreatePartialUserUseCase _createPartialUserUseCase;
  final CompleteUserCreationUseCase _completeUserCreationUseCase;
  final ConfirmFirstStepVerificationUseCase
      _confirmFirstStepVerificationUseCase;
  final ConfirmSecondStepVerificationUseCase
      _confirmSecondStepVerificationUseCase;
  final ConfirmThirdStepVerificationUseCase
      _confirmThirdStepVerificationUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final CleanUserUseCase _cleanUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  UserBloc({
    required GetUserByIdUseCase getUserByIdUseCase,
    required GetUsersByQueryUseCase getUsersByQueryUseCase,
    required CreatePartialUserUseCase createPartialUserUseCase,
    required CompleteUserCreationUseCase completeUserCreationUseCase,
    required ConfirmFirstStepVerificationUseCase
        confirmFirstStepVerificationUseCase,
    required ConfirmSecondStepVerificationUseCase
        confirmSecondStepVerificationUseCase,
    required ConfirmThirdStepVerificationUseCase
        confirmThirdStepVerificationUseCase,
    required UpdateUserUseCase updateUserUseCase,
    required CleanUserUseCase cleanUserUseCase,
    required DeleteUserUseCase deleteUserUseCase,
  })  : _getUserByIdUseCase = getUserByIdUseCase,
        _getUsersByQueryUseCase = getUsersByQueryUseCase,
        _createPartialUserUseCase = createPartialUserUseCase,
        _completeUserCreationUseCase = completeUserCreationUseCase,
        _confirmFirstStepVerificationUseCase =
            confirmFirstStepVerificationUseCase,
        _confirmSecondStepVerificationUseCase =
            confirmSecondStepVerificationUseCase,
        _confirmThirdStepVerificationUseCase =
            confirmThirdStepVerificationUseCase,
        _updateUserUseCase = updateUserUseCase,
        _cleanUserUseCase = cleanUserUseCase,
        _deleteUserUseCase = deleteUserUseCase,
        super(const UserInitialState()) {
    on<GetUserByIdEvent>(_onGetUserById);
    on<GetUsersByQueryEvent>(_onGetUsersByQuery);
    on<CreatePartialUserEvent>(_onCreatePartialUser);
    on<CompleteUserCreationEvent>(_onCompleteUserCreation);
    on<ConfirmFirstStepVerificationEvent>(_onConfirmFirstStepVerification);
    on<ConfirmSecondStepVerificationEvent>(_onConfirmSecondStepVerification);
    on<ConfirmThirdStepVerificationEvent>(_onConfirmThirdStepVerification);
    on<UpdateUserEvent>(_onUpdateUser);
    on<CleanUserEvent>(_onCleanUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onGetUserById(
      GetUserByIdEvent event, Emitter<UserState> emit) async {
    emit(const UserLoadingState());
    final response = await _getUserByIdUseCase(GetUserByIdParams(event.userId));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserLoadedState(user)));
  }

  Future<void> _onGetUsersByQuery(
      GetUsersByQueryEvent event, Emitter<UserState> emit) async {
    emit(const UserLoadingQueryState());
    final response = await _getUsersByQueryUseCase(
        GetUsersByQueryParams(parameter: event.parameter, query: event.query));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (users) => emit(UserLoadedQueryState(users)));
  }

  Future<void> _onCreatePartialUser(
      CreatePartialUserEvent event, Emitter<UserState> emit) async {
    emit(const UserOnPartialCreatingState());
    final response = await _createPartialUserUseCase(
        CreatePartialUserParams(username: event.username));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserOnPartialCreatedState(user)));
  }

  Future<void> _onCompleteUserCreation(
      CompleteUserCreationEvent event, Emitter<UserState> emit) async {
    emit(const UserLoadingState());
    final response = await _completeUserCreationUseCase(
        CompleteUserCreationParams(user: event.user));

    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserCreatedState(user)));
  }

  Future<void> _onConfirmFirstStepVerification(
      ConfirmFirstStepVerificationEvent event, Emitter<UserState> emit) async {
    emit(const UserOnFirstStepVerificationState());
    final response = await _confirmFirstStepVerificationUseCase(
      FirstStepVerificationParams(
        userId: event.userId,
        name: event.name,
        surname: event.surname,
        birthDate: event.birthDate,
        birthAddress: event.birthAddress,
      ),
    );
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserFirstStepVerificationCompletedState(user)));
  }

  Future<void> _onConfirmSecondStepVerification(
      ConfirmSecondStepVerificationEvent event, Emitter<UserState> emit) async {
    emit(const UserOnSecondStepVerificationState());
    final response = await _confirmSecondStepVerificationUseCase(
      SecondStepVerificationParams(
        userId: event.userId,
        residenceAddress: event.residenceAddress,
        email: event.email,
        phoneNumber: event.phoneNumber,
      ),
    );
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserSecondStepVerificationCompletedState(user)));
  }

  Future<void> _onConfirmThirdStepVerification(
      ConfirmThirdStepVerificationEvent event, Emitter<UserState> emit) async {
    emit(const UserOnThirdStepVerificationState());
    final response = await _confirmThirdStepVerificationUseCase(
      ThirdStepVerificationParams(
        userId: event.userId,
        fiscalCode: event.fiscalCode,
      ),
    );
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserThirdStepVerificationCompletedState(user)));
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(const UserUpdatingState());
    final response = await _updateUserUseCase(UpdateUserParams(event.user));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserUpdatedState(user)));
  }

  Future<void> _onCleanUser(
      CleanUserEvent event, Emitter<UserState> emit) async {
    emit(const UserCleaningState());
    final response = await _cleanUserUseCase(CleanUserParams(event.userId));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserCleanedState(user)));
  }

  Future<void> _onDeleteUser(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(const UserDeletingState());
    final response = await _deleteUserUseCase(DeleteUserParams(event.userId));
    response.fold((failure) => emit(UserErrorState(failure.message)),
        (user) => emit(UserDeletedState(user)));
  }
}
