import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

@immutable
sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class UserInitialState extends UserState {
  const UserInitialState();
}

final class UserLoadingState extends UserState {
  const UserLoadingState();
}

final class UserLoadedState extends UserState {
  final User user;

  const UserLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserLoadingQueryState extends UserState {
  const UserLoadingQueryState();
}

final class UserLoadedQueryState extends UserState {
  final List<User> users;

  const UserLoadedQueryState(this.users);

  @override
  List<Object?> get props => users;
}

final class UserOnPartialCreatingState extends UserState {
  const UserOnPartialCreatingState();
}

final class UserOnPartialCreatedState extends UserState {
  final User user;

  const UserOnPartialCreatedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserOnCreateState extends UserState {
  const UserOnCreateState();
}

final class UserCreatedState extends UserState {
  final User user;

  const UserCreatedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserOnFirstStepVerificationState extends UserState {
  const UserOnFirstStepVerificationState();
}

final class UserFirstStepVerificationCompletedState extends UserState {
  final User user;

  const UserFirstStepVerificationCompletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserOnSecondStepVerificationState extends UserState {
  const UserOnSecondStepVerificationState();
}

final class UserSecondStepVerificationCompletedState extends UserState {
  final User user;

  const UserSecondStepVerificationCompletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserOnThirdStepVerificationState extends UserState {
  const UserOnThirdStepVerificationState();
}

final class UserThirdStepVerificationCompletedState extends UserState {
  final User user;

  const UserThirdStepVerificationCompletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserUpdatingState extends UserState {
  const UserUpdatingState();
}

final class UserUpdatedState extends UserState {
  final User user;

  const UserUpdatedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserCleaningState extends UserState {
  const UserCleaningState();
}

final class UserCleanedState extends UserState {
  final User user;

  const UserCleanedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserDeletingState extends UserState {
  const UserDeletingState();
}

final class UserDeletedState extends UserState {
  final User user;

  const UserDeletedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
