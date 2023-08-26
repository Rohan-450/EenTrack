import 'package:flutter/material.dart';

import '../authscreens/shared/custombuttons.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          onPressed: () {},
          iconColor: Colors.white,
          icon: Icons.qr_code_scanner_outlined,
          iconSize: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomElevatedButton(
          text: 'Scan QR',
          onPressed: () {},
        ),
      ],
    );
  }
}
