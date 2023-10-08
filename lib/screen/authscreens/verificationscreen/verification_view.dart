// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authbloc/auth_events.dart';
import '../../../bloc/authbloc/authbloc.dart';
import '../shared/custombuttons.dart';

class VerificationView extends StatelessWidget {
  final bool isLoading;
  final String email;
  const VerificationView({
    super.key,
    required this.email,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Animate(
        effects: const [ShimmerEffect()],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 100,
            ).animate().slideY().fadeIn(),
            SizedBox(
              height: 40,
            ),
            Text(
              "A verification mail has been sent  to $email \n  Please verify to continue !",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            CustomElevatedButton(
              text: 'Verify',
              enabled: !isLoading,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthEventVerifyEmail());
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextButton(
                textColor: Theme.of(context).colorScheme.primary,
                text: 'Did not got a email? click here to resend...',
                enabled: !isLoading,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(AuthEventSendEmailVerification());
                }),
            SizedBox(height: 10),
            CustomTextButton(
              textColor: Theme.of(context).colorScheme.primary,
              text: 'Wrong email? log out here...',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthEventLogout());
              },
            ),
          ],
        ),
      ),
    );
  }
}
