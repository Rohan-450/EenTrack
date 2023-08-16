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
                  "Welcome Back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
								const SizedBox(height: 20),
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
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Dont have an account? register here...",
                        ),
                      ),
                    ),
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
