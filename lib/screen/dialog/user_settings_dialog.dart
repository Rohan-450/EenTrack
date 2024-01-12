import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

enum SettingOptions {
  editProfile,
  logout,
}

Future<SettingOptions?> showSettingsDialog(
  BuildContext context,
  User user,
) {
  return showDialog<SettingOptions>(
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
          const Divider(),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(
              SettingOptions.editProfile,
            ),
            child: const Text(
              "Edit Profile",
              textAlign: TextAlign.center,
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(
              SettingOptions.logout,
            ),
            child: const Text(
              "LogOut",
              textAlign: TextAlign.center,
            ),
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
