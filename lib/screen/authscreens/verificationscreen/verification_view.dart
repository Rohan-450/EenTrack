// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 100,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "A verification mail has been sent \n to the registered email\nPlease verify to continue !",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              CustomElevatedButton(
                buttonText: 'Verify',
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextButton(
                  buttonText: 'Did not got a email? click here to resend...',
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
