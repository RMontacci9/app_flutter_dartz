import 'package:dartz/dartz.dart';

import '../exceptions/login_failure.dart';

abstract class LoginRepository {
  Future<Either<LoginFailure, String>> call(String login, String password);
}
