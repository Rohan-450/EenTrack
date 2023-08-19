import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';

class NewMeetingScreen extends StatelessWidget {
  const NewMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomElevatedButton(
              buttonText: 'New Meeting',
              onPressed: () {},
            ),
          ),
					const SizedBox(height: 20),
          Center(
            child: CustomTextButton(
              buttonText: 'Show previous meetings...',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
