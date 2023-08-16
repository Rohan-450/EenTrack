import 'package:flutter/material.dart';

import 'login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
			child: const LoginView()
			),
    );
  }
}
