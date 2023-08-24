import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';
import 'package:project_f/services/qrServices/qr_serivces.dart';

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodeGenerator(),
                ),
              );
            },
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
