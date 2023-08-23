import 'package:flutter/material.dart';

import 'verification_view.dart';

class VerificationScreen extends StatelessWidget {
  final bool isLoading;
  final String email;
  final String? error;
  const VerificationScreen({
    super.key,
    required this.email,
    this.isLoading = false,
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
        child: VerificationView(email: email, isLoading: isLoading),
      ),
    );
  }
}
