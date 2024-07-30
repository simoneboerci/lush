import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitialState extends AuthState {
  const AuthInitialState();
}

final class AuthOnLoadingCurrentUserState extends AuthState {
  const AuthOnLoadingCurrentUserState();
}

final class AuthLoadedCurrentUserState extends AuthState {
  final String currentUserId;

  const AuthLoadedCurrentUserState(this.currentUserId);

  @override
  List<Object?> get props => [currentUserId];
}

final class AuthOnFastRegistrationState extends AuthState {
  const AuthOnFastRegistrationState();
}

final class AuthFastRegistrationCompletedState extends AuthState {
  final String userId;
  final String username;

  const AuthFastRegistrationCompletedState({
    required this.userId,
    required this.username,
  });

  @override
  List<Object?> get props => [userId, username];
}

final class AuthOnCompleteRegistrationState extends AuthState {}

final class AuthCompleteRegistrationCompletedState extends AuthState {
  final User user;

  const AuthCompleteRegistrationCompletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthOnLoginState extends AuthState {
  const AuthOnLoginState();
}

final class AuthLoginCompletedState extends AuthState {
  final User user;

  const AuthLoginCompletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthOnLogoutState extends AuthState {
  const AuthOnLogoutState();
}

final class AuthLogoutCompletedState extends AuthState {
  const AuthLogoutCompletedState();
}

final class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
