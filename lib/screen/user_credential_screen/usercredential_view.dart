import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:random_avatar/random_avatar.dart';

import '../authscreens/shared/custombuttons.dart';
import '../authscreens/shared/customtextbox.dart';

class UserCredFormView extends StatefulWidget {
  final User user;
  final Function(User) onSubmit;
  const UserCredFormView({
    super.key,
    required this.user,
    required this.onSubmit,
  });

  @override
  State<UserCredFormView> createState() => _UserCredFormViewState();
}

class _UserCredFormViewState extends State<UserCredFormView> {
  final _formKey = GlobalKey<FormState>();

  User get user => widget.user;

  @override
  void initState() {
    super.initState();
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
                      child:
                          RandomAvatar(user.name.isEmpty ? 'Dark' : user.name),
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
                      initialValue: user.name,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (name) {
                        user.name = name.trim();
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Department ie. CSE ECE etc.",
                      initialValue: user.department,
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
                        user.department = department.trim().toUpperCase();
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
                            initialValue: user.roll,
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
                              user.roll = rollNo.trim();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextBox(
                            label: "Semester ie. 1st, 2nd, 3rd...",
                            initialValue: user.semester,
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
                              user.semester = semester.trim();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      label: 'Email',
                      onChanged: (_) {},
                      initialValue: user.email,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Linkedin",
                      initialValue: user.linkedin,
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
                        user.linkedin = linkedin.trim();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextBox(
                      label: "Github",
                      initialValue: user.github,
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
                        user.github = github.trim();
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
                        widget.onSubmit(user);
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
