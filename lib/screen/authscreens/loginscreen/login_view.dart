import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';

class LoginView extends StatefulWidget {
  final String email;
  final String password;
  final bool isLoading;
  const LoginView({
    super.key,
    this.email = '',
    this.password = '',
    this.isLoading = false,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(email) {
    if (email?.isEmpty == true) {
      return "Email is required";
    }
    if (email != null && !email.contains("@")) {
      return "Email is invalid";
    }
    return null;
  }

  String? validatePassword(password) {
    if (password?.isEmpty == true) {
      return "Password is required";
    }
    if (password != null && password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    email = widget.email;
    password = widget.password;
  }

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
                  enabled: !widget.isLoading,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (email) {
                    this.email = email;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Password",
                    enabled: !widget.isLoading,
                    validator: validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    onChanged: (password) {
                      this.password = password;
                    }),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Login',
                  enabled: !widget.isLoading,
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                CustomTextButton(
                  text: "Don't have an account? register here...",
                  enabled: !widget.isLoading,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
