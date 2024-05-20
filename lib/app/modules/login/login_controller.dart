import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';
import 'package:flutter_dartz/app/modules/home/home_module.dart';
import 'package:flutter_dartz/app/repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginRepository _repository;

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable //torna essa propriedade como observavel
  bool loading = false;

  @observable
  Option<LoginFailure> failure;

  LoginControllerBase(this._repository);

  @action
  void login() async {
    loading = true;
    failure =
        none(); // na programação funcional não trabalhamos com nulo. Logo, dizemos que ele, o failure, é nada

    final loginResult =
        await _repository.call(loginController.text, passwordController.text);

    loginResult.fold((error) {
      failure = optionOf(
          error); //vou mandar pro meu option o erro que deu na minha requisição. Se for nulo será none, se houver resultado será some
      loading = false;
    }, (success) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('access_token', success);
      loading = false;
      Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
    });
  }
}
