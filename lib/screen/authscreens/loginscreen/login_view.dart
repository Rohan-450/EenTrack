import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 50),
              CustomTextBox(
                  label: "Email",
                  onChanged: (email) {
                    this.email = email;
                  }),
              const SizedBox(height: 20),
              CustomTextBox(
                  label: "Password",
                  onChanged: (password) {
                    this.password = password;
                  }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
