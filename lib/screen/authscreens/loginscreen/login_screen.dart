import 'package:flutter/material.dart';

import 'login_view.dart';

class LoginScreen extends StatelessWidget {
  final String email;
  final String password;
  final String? isLoading;
  final String? error;

  const LoginScreen({
    super.key,
    this.email = '',
    this.password = '',
    this.isLoading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error!),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: LoginView(
            email: email,
            password: password,
            isLoading: isLoading,
            error: error,
          )),
    );
  }
}
