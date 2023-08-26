import 'package:flutter/material.dart';
import 'package:project_f/screen/userCredentialscreen/usercredential_view.dart';

class UserCredForm extends StatelessWidget {
  final String email;
  const UserCredForm({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: UserCredFormView(email: email),
      ),
    );
  }
}
