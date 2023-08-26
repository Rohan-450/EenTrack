import 'package:flutter/material.dart';

enum Option { ok, cancel }

Future<Option> showAlartDialog(
    String title, String message, BuildContext context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(Option.ok);
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(Option.cancel);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      })) {
    case Option.ok:
      return Option.ok;
    case Option.cancel:
      return Option.cancel;
    default:
      return Option.cancel;
  }
}
