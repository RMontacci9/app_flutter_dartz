import 'package:flutter_dartz/app/exceptions/login_failure.dart';
import 'package:flutter_dartz/app/modules/login/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:edge_alerts/edge_alerts.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

// ignore: deprecated_member_use
class LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reaction((_) => controller.failure, (_) {
      controller.failure.map((f) {
        String message;
        if (f is LoginNotFoundErrorFailure) {
          message = 'Login ou senha não encontrados';
        } else {
          message = 'Erro ao realizar o login';
        }
        edgeAlert(context,
            title: 'Erro',
            description: message,
            gravity: Gravity.top,
            duration: 5,
            backgroundColor: Colors.red,
            icon: Icons.error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: controller.loginController,
              decoration: const InputDecoration(labelText: 'login'),
            ),
            TextFormField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
                onPressed: () => controller.login(), child: Text('login'))
          ],
        ),
      ),
    );
  }
}
