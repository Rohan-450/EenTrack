import 'dart:convert';

import 'package:eentrack/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';

class DetailsQrView extends StatelessWidget {
  final User user;
  const DetailsQrView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var userMap = user.toMap();
    var userString = jsonEncode(userMap);
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: QRCode(
        data: userString,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    ));
  }
}
