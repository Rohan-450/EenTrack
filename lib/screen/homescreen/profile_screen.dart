import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../authscreens/shared/customcontainer.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

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
            CustomContainer(
              text: user.name,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: user.department,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    text: user.rollNo,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomContainer(
                    text: user.semester,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: user.github.isEmpty ? 'Github Not Available' : user.github,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: user.linkedin.isEmpty
                  ? 'LinkedIn Not Available'
                  : user.linkedin,
            ),
          ],
        ),
      ),
    );
  }
}
