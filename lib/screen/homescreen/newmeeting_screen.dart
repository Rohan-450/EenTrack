import 'package:flutter/material.dart';

import '../authscreens/shared/custombuttons.dart';

class NewMeetingScreen extends StatelessWidget {
  const NewMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CustomElevatedButton(
            text: 'New Meeting',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: CustomTextButton(
            text: 'Show previous meetings...',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
