import 'package:flutter/material.dart';

import 'login_page.dart';
import 'sign_up_page.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogged = true;

  @override
  Widget build(BuildContext context) {
    return isLogged
        ? LoginPage(onClickSignUp: switchAuthPages)
        : SignUpPage(onClickedSignIn: switchAuthPages);
  }
  void switchAuthPages() => setState(() {
        isLogged = !isLogged;
      });
}