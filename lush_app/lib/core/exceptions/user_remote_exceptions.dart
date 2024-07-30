class UserRemoteException implements Exception {
  final String message;

  const UserRemoteException(this.message);
}

class UserNotFoundException extends UserRemoteException {
  const UserNotFoundException(super.message);
}

class SaveUserException extends UserRemoteException {
  const SaveUserException(super.message);
}

class UpdateUserException extends UserRemoteException {
  const UpdateUserException(super.message);
}

class DeleteUserException extends UserRemoteException {
  const DeleteUserException(super.message);
}

class CleanUserException extends UserRemoteException {
  const CleanUserException(super.message);
}

class GetUsersByQueryException extends UserRemoteException {
  const GetUsersByQueryException(super.message);
}

class FirstStepVerificationException extends UserRemoteException {
  const FirstStepVerificationException(super.message);
}

class SecondStepVerificationException extends UserRemoteException {
  const SecondStepVerificationException(super.message);
}

class ThirdStepVerificationException extends UserRemoteException {
  const ThirdStepVerificationException(super.message);
}
