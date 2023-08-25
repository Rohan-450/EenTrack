import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/bloc/authbloc/auth_events.dart';
import 'package:project_f/bloc/authbloc/authbloc.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';

class RegisterView extends StatefulWidget {
  final String email;
  final String password;
  final String? loading;

  const RegisterView({
    super.key,
    this.email = '',
    this.password = '',
    this.loading,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String email;
  late String password;
  String confirmPassword = '';

  late final GlobalKey<FormState> _formKey;

  String? validateEmail(email) {
    if (email?.isEmpty == true) {
      return "Email is required";
    }
    if (email != null && !email.contains("@")) {
      return "Email is invalid";
    }
    return null;
  }

  String? validatePassword(pass) {
    if (pass?.isEmpty == true) {
      return "Password is required";
    }
    if (pass != null && pass.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(cpass) {
    if (cpass?.isEmpty == true) {
      return "Confirm Password is required";
    }
    if (cpass != null && cpass != password) {
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
                Text(
                  widget.loading == null ? "Welcome Onboard !" : widget.loading!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextBox(
                  label: "Email",
                  initialValue: email,
                  enabled: widget.loading == null,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                  onChanged: (e) {
                    email = e;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Password",
                    initialValue: password,
                    enabled: widget.loading == null,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: validatePassword,
                    obscureText: true,
                    onChanged: (pass) {
                      password = pass;
                    }),
                const SizedBox(height: 20),
                CustomTextBox(
                    label: "Confirm Password",
                    enabled: widget.loading == null,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: validateConfirmPassword,
                    obscureText: true,
                    onChanged: (pass) {
                      confirmPassword = pass;
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  text: 'Register',
                  enabled: widget.loading == null,
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    BlocProvider.of<AuthBloc>(context).add(AuthEventRegister(
                      email: email,
                      password: password,
                    ));
                  },
                ),
                const SizedBox(width: 10),
                CustomTextButton(
                  text: 'Already have an account? Log In...',
                  enabled: widget.loading == null,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthEventShowLogin(
                      email: email,
                      password: password,
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
