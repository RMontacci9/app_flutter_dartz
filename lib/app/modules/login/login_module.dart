import 'package:flutter_dartz/app/modules/login/login_page.dart';
import 'package:flutter_dartz/app/modules/login/login_controller.dart';
import 'package:flutter_dartz/app/repository/login_repository_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => LoginRepositoryImp()),
    Bind((i) => LoginController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
  ];
}
