import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eentrack/bloc/authbloc/auth_events.dart';
import 'package:eentrack/bloc/authbloc/authbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_avatar/random_avatar.dart';

import '../authscreens/shared/custombuttons.dart';
import '../authscreens/shared/customtextbox.dart';

class UserCredFormView extends StatefulWidget {
  final String email;
  const UserCredFormView({
    super.key,
    required this.email,
  });

  @override
  State<UserCredFormView> createState() => _UserCredFormViewState();
}

class _UserCredFormViewState extends State<UserCredFormView> {
  late String email;
  String name = '';
  String department = '';
  String rollNo = '';
  String semester = '';
  String github = '';
  String linkedin = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Animate(
                effects: const [ShimmerEffect()],
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: RandomAvatar(name.isEmpty ? 'Dark' : name),
                    ).animate().slideY().fadeIn(),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Enter your details...',
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Enter your full name",
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (name) {
                        this.name = name.trim();
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Department ie. CSE ECE etc.",
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Department cannot be empty';
                        }
                        if (p0.length < 2 || p0.length > 4) {
                          return 'Length of department should be between 2 and 4';
                        }
                        if (p0.contains(RegExp(r'[0-9]'))) {
                          return 'Please enter a valid department';
                        }
                        return null;
                      },
                      onChanged: (department) {
                        this.department = department.trim().toUpperCase();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextBox(
                            label: "Full college roll...",
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your roll number';
                              }
                              if (p0.contains(RegExp(r'[a-zA-Z]'))) {
                                return 'Please enter a valid roll number';
                              }
                              return null;
                            },
                            onChanged: (rollNo) {
                              this.rollNo = rollNo.trim();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextBox(
                            label: "Semester ie. 1st, 2nd, 3rd...",
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your semester';
                              }
                              if (p0.length != 3) {
                                return 'Length of semester should be 3';
                              }
                              return null;
                            },
                            onChanged: (semester) {
                              this.semester = semester.trim();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      label: 'Email',
                      onChanged: (_) {},
                      initialValue: widget.email,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Linkedin",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (!value.contains('linkedin.com')) {
                          return 'Please enter a valid linkedin';
                        }
                        return null;
                      },
                      onChanged: (linkedin) {
                        this.linkedin = linkedin.trim();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Github",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (!value.contains('github.com')) {
                          return 'Please enter a valid github';
                        }
                        return null;
                      },
                      onChanged: (github) {
                        this.github = github.trim();
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomElevatedButton(
                      text: "Submit",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthEventAddUserDetails(
                            name: name,
                            department: department,
                            email: email,
                            rollNo: rollNo,
                            semester: semester,
                            github: github,
                            linkedin: linkedin,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
