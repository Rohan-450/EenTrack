import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:random_avatar/random_avatar.dart';

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
      child: Animate(
      effects: const [ShimmerEffect()],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  child: RandomAvatar(user.name),
                ).animate().slideY().fadeIn(),
                const SizedBox(
                  height: 20,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Hello ${user.name}...',
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      curve: Curves.easeInOut,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
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
                  text: user.github.isEmpty
                      ? 'Github Not Available'
                      : user.github,
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
      ),
    );
  }
}
