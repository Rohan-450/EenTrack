import 'package:flutter/material.dart';
import 'package:project_f/services/qrServices/camera_services.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Expanded(child: CameraSrevices()),
        ),
      ],
    );
  }
}
