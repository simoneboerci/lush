import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/auth/domain/params/get_current_user_id_params.dart';
import 'package:lush_app/features/auth/domain/params/login_anonymously_params.dart';
import 'package:lush_app/features/auth/domain/params/login_with_email_and_password_params.dart';
import 'package:lush_app/features/auth/domain/params/login_with_google_params.dart';
import 'package:lush_app/features/auth/domain/params/register_with_email_and_password_params.dart';
import 'package:lush_app/features/auth/domain/usecases/get_current_user_id_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_anonymously_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_with_email_and_password_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:lush_app/features/auth/domain/usecases/register_with_email_and_password_use_case.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:lush_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserIdUseCase _getCurrentUserIdUseCase;
  final RegisterWithEmailAndPasswordUseCase
      _registerWithEmailAndPasswordUseCase;
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginAnonymouslyUseCase _loginAnonymouslyUseCase;

  AuthBloc({
    required GetCurrentUserIdUseCase getCurrentUserIdUserCase,
    required RegisterWithEmailAndPasswordUseCase
        registerWithEmailAndPasswordUseCase,
    required LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase,
    required LoginWithGoogleUseCase loginWithGoogleUseCase,
    required LoginAnonymouslyUseCase loginAnonymouslyUseCase,
  })  : _getCurrentUserIdUseCase = getCurrentUserIdUserCase,
        _registerWithEmailAndPasswordUseCase =
            registerWithEmailAndPasswordUseCase,
        _loginWithEmailAndPasswordUseCase = loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase = loginWithGoogleUseCase,
        _loginAnonymouslyUseCase = loginAnonymouslyUseCase,
        super(const AuthInitialState()) {
    on<AuthGetCurrentUserIdEvent>(_onGetCurrentUserId);
    on<AuthRegisterWithEmailAndPasswordEvent>(_onRegisterWithEmailAndPassword);
    on<AuthLoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
    on<AuthLoginWithGoogleEvent>(_onLoginWithGoogle);
    on<AuthLoginAnonymouslyEvent>(_onLoginAnonymously);

    add(const AuthGetCurrentUserIdEvent());
  }

  Future<void> _onGetCurrentUserId(
      AuthGetCurrentUserIdEvent event, Emitter<AuthState> emit) async {
    emit(const AuthOnLoadingCurrentUserState());
    final response =
        await _getCurrentUserIdUseCase(const GetCurrentUserIdParams());
    response.fold((_) => emit(const AuthLogoutCompletedState()),
        (userId) => emit(AuthLoadedCurrentUserState(userId)));
  }

  Future<void> _onRegisterWithEmailAndPassword(
      AuthRegisterWithEmailAndPasswordEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthOnCompleteRegistrationState());
    final response = await _registerWithEmailAndPasswordUseCase(
        RegisterWithEmailAndPasswordParams(
      email: event.email,
      password: event.password,
    ));

    response.fold((failure) => emit(AuthErrorState(failure.message)),
        (user) => emit(AuthCompleteRegistrationCompletedState(user)));
  }

  Future<void> _onLoginWithEmailAndPassword(
      AuthLoginWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthOnLoginState());
    final response =
        await _loginWithEmailAndPasswordUseCase(LoginWithEmailAndPasswordParams(
      email: event.email,
      password: event.password,
    ));

    response.fold((failure) => emit(AuthErrorState(failure.message)),
        (user) => emit(AuthLoginCompletedState(user)));
  }

  Future<void> _onLoginWithGoogle(
      AuthLoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(const AuthOnLoginState());
    final response =
        await _loginWithGoogleUseCase(const LoginWithGoogleParams());

    response.fold((failure) => emit(AuthErrorState(failure.message)),
        (user) => emit(AuthLoginCompletedState(user)));
  }

  Future<void> _onLoginAnonymously(
      AuthLoginAnonymouslyEvent event, Emitter<AuthState> emit) async {
    emit(const AuthOnFastRegistrationState());
    final response = await _loginAnonymouslyUseCase(
        LoginAnonymouslyParams(username: event.username));

    response.fold(
        (failure) => emit(AuthErrorState(failure.message)),
        (user) => emit(AuthFastRegistrationCompletedState(
            userId: user.id, username: user.chatInfo.username ?? '')));
  }
}
