import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserByIdEvent extends UserEvent {
  final String userId;

  const GetUserByIdEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

final class GetUsersByQueryEvent extends UserEvent {
  final String parameter;
  final String query;
  final bool skipCurrentUser;

  const GetUsersByQueryEvent({
    required this.parameter,
    required this.query,
    this.skipCurrentUser = true,
  });

  @override
  List<Object?> get props => [parameter, query, skipCurrentUser];
}

final class CreatePartialUserEvent extends UserEvent {
  final String username;

  const CreatePartialUserEvent(this.username);

  @override
  List<Object?> get props => [username];
}

final class CompleteUserCreationEvent extends UserEvent {
  final User user;

  const CompleteUserCreationEvent(this.user);

  @override
  List<Object?> get props => [user];
}

final class ConfirmFirstStepVerificationEvent extends UserEvent {
  final String userId;
  final String name;
  final String surname;
  final DateTime birthDate;
  final String birthAddress;

  const ConfirmFirstStepVerificationEvent({
    required this.userId,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.birthAddress,
  });

  @override
  List<Object?> get props => [userId, name, surname, birthDate, birthAddress];
}

final class ConfirmSecondStepVerificationEvent extends UserEvent {
  final String userId;
  final String residenceAddress;
  final String email;
  final String phoneNumber;

  const ConfirmSecondStepVerificationEvent({
    required this.userId,
    required this.residenceAddress,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [userId, residenceAddress, email, phoneNumber];
}

final class ConfirmThirdStepVerificationEvent extends UserEvent {
  final String userId;
  final String fiscalCode;

  const ConfirmThirdStepVerificationEvent({
    required this.userId,
    required this.fiscalCode,
  });

  @override
  List<Object?> get props => [userId, fiscalCode];
}

final class UpdateUserEvent extends UserEvent {
  final User user;

  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

final class CleanUserEvent extends UserEvent {
  final String userId;

  const CleanUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

final class DeleteUserEvent extends UserEvent {
  final String userId;

  const DeleteUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
