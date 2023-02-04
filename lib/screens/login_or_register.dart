import 'package:auth_practice/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'register_page.dart';

class LoginOrRegister extends StatefulWidget {
  bool showLoginPage = true;
  LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//intitially show login page

//toggle between login and register
  void togglePages() {
    setState(() {
      widget.showLoginPage = !widget.showLoginPage;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showLoginPage) {
      return LoginPage(
        onTap: () {
          togglePages();
        },
      );
    } else {
      return RegisterPage(
        onTap: () {
         togglePages();
        },
      );
    }
  }
}
