class LoginFailure implements Exception {}

class LoginServerErrorFailure extends LoginFailure {
  LoginServerErrorFailure({
    required this.error,
  });

  String error;
}

class LoginNotFoundErrorFailure extends LoginFailure {}
