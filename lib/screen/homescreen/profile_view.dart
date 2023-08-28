import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/user_model.dart';
import '../authscreens/shared/customcontainer.dart';

class ProfileView extends StatelessWidget {
  final User user;
  const ProfileView({
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
        child: SingleChildScrollView(
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
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
                      text: user.roll,
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
                text:
                    user.github.isEmpty ? 'Github Not Available' : user.github,
                trailing: IconButton(
                  onPressed: () {
                    copyToClipboard(user.github);
                  },
                  icon: const Icon(Icons.copy),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextWidget(
                text: user.linkedin.isEmpty
                    ? 'LinkedIn Not Available'
                    : user.linkedin,
                trailing: IconButton(
                  onPressed: () {
                    copyToClipboard(user.linkedin);
                  },
                  icon: const Icon(Icons.copy),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
