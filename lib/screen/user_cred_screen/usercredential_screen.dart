import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';

import 'usercredential_view.dart';

class UserCredForm extends StatelessWidget {
  final User user;
  final Function(User) onSubmit;
  const UserCredForm({
    super.key,
    required this.user,
    required this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: UserCredFormView(user: user,onSubmit: onSubmit,),
      ),
    );
  }
}
