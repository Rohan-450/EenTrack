import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';

class RegisterView extends StatefulWidget {
  final String email;
  final String password;
  final bool isLoading;

  const RegisterView({
    super.key,
    this.email = '',
    this.password = '',
    this.isLoading = false,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String email;
  late String password;
  String confirmPassword = '';

  late final GlobalKey _formKey;

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

  String? validateConfirmPassword(confirmPassword) {
    if (confirmPassword?.isEmpty == true) {
      return "Confirm Password is required";
    }
    if (confirmPassword != null && confirmPassword != password) {
      return "Confirm Password must match password";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    email = widget.email;
    password = widget.password;
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
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
                  enabled: !widget.isLoading,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                  onChanged: (email) {
                    this.email = email;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Password",
                    enabled: !widget.isLoading,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: validatePassword,
                    onChanged: (password) {
                      this.password = password;
                    }),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Confirm Password",
                    enabled: !widget.isLoading,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: validateConfirmPassword,
                    onChanged: (password) {
                      this.password = confirmPassword;
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  text: 'Register',
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                CustomElevatedButton(
                  text: 'Already have an account? Log In...',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
