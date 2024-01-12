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
        alignment: Alignment.center,
        title: Text(
          user.name,
          textAlign: TextAlign.center,
        ),
        children: [
          CircleAvatar(
            radius: 50,
            child: RandomAvatar(user.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.email,
              textAlign: TextAlign.center,
            ),
          ),
          SimpleDialogOption(
            child: const Text(
              "Edit Profile",
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.pop(context);
              bloc.add(AuthEventShowUpdateUserDetails(user: user));
            },
          ),
          SimpleDialogOption(
            child: const Text(
              "LogOut",
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.pop(context);
              bloc.add(AuthEventLogout());
            },
          ),
          SimpleDialogOption(
            child: const Text(
              "Close",
              textAlign: TextAlign.center,
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
