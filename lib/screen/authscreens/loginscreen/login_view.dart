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
              child: Column(children: [
            Column(
              children: [
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            const SizedBox(
              height: 100,
              child: Text(
                "Welcome Back!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: const Color.fromARGB(255, 59, 55, 55),
                  child: CustomTextBox(
                      label: "Email",
                      onChanged: (email) {
                        this.email = email;
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: const Color.fromARGB(255, 59, 55, 55),
                  child: CustomTextBox(
                      label: "Password",
                      onChanged: (password) {
                        this.password = password;
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ])),
        ),
      ),
    );
  }
}
