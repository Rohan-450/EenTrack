import 'package:eentrack/bloc/authbloc/auth_bloc.dart';
import 'package:eentrack/bloc/authbloc/auth_events.dart';
import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_avatar/random_avatar.dart';

void showUserProfileDialog(
  BuildContext context,
  User user,
) {
  var bloc = BlocProvider.of<AuthBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(user.name),
        children: [
          Text(user.email),
          CircleAvatar(
            radius: 20,
            child: RandomAvatar(user.name),
          ),
          SimpleDialogOption(
            child: const Text(
              "Edit Profile",
            ),
            onPressed: () {
              bloc.add(AuthEventShowUpdateUserDetails(user: user));
            },
          ),
          SimpleDialogOption(
            child: const Text(
              "LogOut",
            ),
            onPressed: () {
              bloc.add(AuthEventLogout());
            },
          ),
          SimpleDialogOption(
            child: const Text(
              "Close",
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
