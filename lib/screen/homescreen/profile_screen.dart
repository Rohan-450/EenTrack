import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/user_model.dart';
import '../authscreens/shared/customcontainer.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile_dummy.jpg'),
              radius: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Hello ${user.name}!!',
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextWidget(
              text: user.name,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextWidget(
              text: user.department,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: user.rollNo,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: user.semester,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextWidget(
              text: user.github ?? 'Not found',
              trailing: IconButton(
                onPressed: () => copyToClipboard(user.github ?? 'Not found'),
                icon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextWidget(
              text: user.linkedin ?? 'Not found',
              trailing: IconButton(
                onPressed: () => copyToClipboard(user.linkedin ?? 'Not found'),
                icon: const Icon(Icons.link),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
