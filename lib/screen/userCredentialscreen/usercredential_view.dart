import 'package:eentrack/bloc/authbloc/auth_events.dart';
import 'package:eentrack/bloc/authbloc/authbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: Column(children: [
                RawMaterialButton(
                  fillColor: Colors.grey,
                  onPressed: () {},
                  elevation: 2.0,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.black,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter your details !",
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
                    this.name = name;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  label: "Enter your department",
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter your department';
                    }
                    if (p0.length > 3 || p0.length < 3) {
                      return 'Please enter a valid department';
                    }
                    return null;
                  },
                  onChanged: (department) {
                    this.department = department;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextBox(
                        label: "Roll number",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter your roll number';
                          }
                          return null;
                        },
                        onChanged: (rollNo) {
                          this.rollNo = rollNo;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextBox(
                        label: "Semester",
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter your semester';
                          }
                          if (p0.length != 3) {
                            return 'Please enter a valid semester';
                          }
                          return null;
                        },
                        onChanged: (semester) {
                          this.semester = semester;
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
                  onChanged: (linkedin) {
                    this.linkedin = linkedin;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  label: "Github",
                  onChanged: (github) {
                    this.github = github;
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
              ])),
            )),
      ),
    );
  }
}
