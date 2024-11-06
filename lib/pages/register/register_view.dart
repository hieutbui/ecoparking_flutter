import 'package:ecoparking_flutter/pages/register/register.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controller;

  const RegisterView({
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
