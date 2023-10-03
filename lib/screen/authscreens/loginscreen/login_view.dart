import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authbloc/auth_events.dart';
import '../../../bloc/authbloc/authbloc.dart';
import '../shared/custombuttons.dart';
import '../shared/customtextbox.dart';

class LoginView extends StatefulWidget {
  final String email;
  final String password;
  final String? isLoading;
  const LoginView({
    super.key,
    this.email = '',
    this.password = '',
    this.isLoading,
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

  String getMessageText() {
    if (widget.isLoading != null) {
      return widget.isLoading!;
    }
    return 'Welcome back...';
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
            child: Animate(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ).animate().fadeIn(),
                  const SizedBox(
                    height: 50,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        getMessageText(),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        curve: Curves.bounceInOut,
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                  const SizedBox(height: 20),
                  CustomTextBox(
                    label: "Email",
                    initialValue: email,
                    enabled: widget.isLoading == null,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (email) {
                      this.email = email;
                    },
                  ).animate().shimmer(),
                  const SizedBox(height: 20),
                  CustomTextBox(
                      label: "Password",
                      initialValue: password,
                      enabled: widget.isLoading == null,
                      validator: validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChanged: (password) {
                        this.password = password;
                      }).animate().shimmer(),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'Login',
                    enabled: widget.isLoading == null,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      BlocProvider.of<AuthBloc>(context).add(AuthEventLogin(
                        email: email,
                        password: password,
                      ));
                    },
                  ).animate().shimmer(),
                  CustomTextButton(
                    text: "Don't have an account? Register here...",
                    enabled: widget.isLoading == null,
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthEventShowRegister(email: email, password: password),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
