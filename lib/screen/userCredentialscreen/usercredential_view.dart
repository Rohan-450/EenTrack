// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/screen/authscreens/shared/customtextbox.dart';
import 'package:project_f/screen/homescreen/home_screen.dart';
import 'package:project_f/screen/homescreen/profile_screen.dart';

class UserCredentialView extends StatefulWidget {
  const UserCredentialView({super.key});

  @override
  State<UserCredentialView> createState() => _UserCredentialViewState();
}

class _UserCredentialViewState extends State<UserCredentialView> {
  String name = '';
  String department = '';
  String rollNo = '';
  String semester = '';
  String github = '';
  String linkedin = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: SingleChildScrollView(
                child: Column(children: [
              RawMaterialButton(
                onPressed: () {},
                fillColor: Colors.grey,
                elevation: 2.0,
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enter your details !",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextBox(
                label: "Enter your full name",
                onChanged: (name) {
                  this.name = name;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextBox(
                label: "Enter your department",
                onChanged: (department) {
                  this.department = department;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextBox(
                      label: "Roll number",
                      onChanged: (rollNo) {
                        this.rollNo = rollNo;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextBox(
                      label: "Semester",
                      onChanged: (semester) {
                        this.semester = semester;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextBox(
                label: "Linkedin",
                onChanged: (linkedin) {
                  this.linkedin = linkedin;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextBox(
                label: "Github",
                onChanged: (github) {
                  this.github = github;
                },
              ),
              SizedBox(
                height: 60,
              ),
              CustomElevatedButton(
                text: "Submit",
                onPressed: () {
//to be implemented using block

                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                name: name,
                                department: department,
                                rollNo: rollNo,
                                semester: semester,
                                github: github,
                                linkedin: linkedin)));
                  }
                },
              ),
            ])),
          )),
    );
  }
}
