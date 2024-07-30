import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthGetCurrentUserIdEvent extends AuthEvent {
  const AuthGetCurrentUserIdEvent();
}

final class AuthLoginAnonymouslyEvent extends AuthEvent {
  final String username;

  const AuthLoginAnonymouslyEvent({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}

final class AuthRegisterWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthRegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class AuthLoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class AuthLoginWithGoogleEvent extends AuthEvent {
  const AuthLoginWithGoogleEvent();
}

final class AuthLogoutState extends AuthEvent {
  const AuthLogoutState();
}
