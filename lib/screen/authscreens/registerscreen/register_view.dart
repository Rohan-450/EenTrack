// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_f/colors/get_hexcolor.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome Onboard !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextBox(
                  label: "Email",
                  onChanged: (email) {
                    this.email = email;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextBox(
                    label: "Password",
                    onChanged: (password) {
                      this.password = password;
                    }),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Confirm Password",
                    labelColor: HexColor.getColorFromHex('#312D2D'),
                    onChanged: (password) {
                      this.password = password;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        buttonText: 'Register',
                        textcolor: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextButton(
                      buttonText: 'Do not have an account? Sign In',
                      textcolor: Colors.blue,
                      onPressed: () {},
                    )),
                    const SizedBox(width: 20),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
