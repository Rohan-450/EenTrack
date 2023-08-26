import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/registerscreen/register_view.dart';

class RegisterScreen extends StatelessWidget {
  final String email;
  final String password;
  final String? loading;
  final String? error;
  const RegisterScreen({
    super.key,
    this.email = '',
    this.password = '',
    this.loading,
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
        child: RegisterView(
          email: email,
          password: password,
          loading: loading,
        ),
      ),
    );
  }
}
