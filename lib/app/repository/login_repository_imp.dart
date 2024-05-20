import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';

import 'login_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  @override
  Future<Either<LoginFailure, String>> call(
      String login, String password) async {
    try {
      final response = await Dio().post('http://localhost:8888/auth/login',
          data: {'login': login, 'password': password});

      return right(response.data['token']);
    } on DioException catch (e) {
      //aqui tratamos exceções da propria conexão do dio
      print(e);
      if (e.response?.statusCode == 403) {
        left(LoginNotFoundErrorFailure());
        //403 é acesso negado ou login não encontrado
      }
      return left(LoginServerErrorFailure(error: 'Server error'));
    } catch (e) {
      //aqui nesse catch sozinho tratamos qualquer outra exceção
      return left(LoginServerErrorFailure(error: 'Server error'));
    }

    //aqui é o unico local que colocamaos um try catch
  }
}
