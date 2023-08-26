import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/customcontainer.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String department;
  final String rollNo;
  final String semester;
  final String github;
  final String linkedin;
  const ProfileScreen({
    super.key,
    required this.name,
    required this.department,
    required this.rollNo,
    required this.semester,
    required this.github,
    required this.linkedin,
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
              'Hello $name',
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
              text: name,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: department,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    text: rollNo,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomContainer(
                    text: semester,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: github,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              text: linkedin,
            ),
          ],
        ),
      ),
    );
  }
}
