import 'package:ecoparking_flutter/pages/login/login.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;

  const LoginView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Login Page'),
    );
  }
}
