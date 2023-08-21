import 'package:flutter/material.dart';

import 'verification_view.dart';

class VerificationScreen extends StatelessWidget {
  final bool isLoading;
  final String? error;
  const VerificationScreen({
    super.key,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Scaffold(
        body: Center(
          child: Text(error!),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: VerificationView(isLoading: isLoading),
      ),
    );
  }
}
