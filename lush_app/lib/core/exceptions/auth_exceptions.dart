class AuthException implements Exception {
  final String message;

  const AuthException(this.message);
}

class AuthRegistrationException extends AuthException {
  AuthRegistrationException(super.message);
}

class AuthRegistrationWithEmailAndPasswordException
    extends AuthRegistrationException {
  AuthRegistrationWithEmailAndPasswordException(super.message);
}

class AuthLoginException extends AuthException {
  AuthLoginException(super.message);
}

class AuthLoginWithEmailAndPasswordException extends AuthLoginException {
  AuthLoginWithEmailAndPasswordException(super.message);
}

class AuthLoginWithGoogleException extends AuthLoginException {
  AuthLoginWithGoogleException(super.message);
}

class AuthLoginAnonymouslyException extends AuthLoginException {
  AuthLoginAnonymouslyException(super.message);
}
