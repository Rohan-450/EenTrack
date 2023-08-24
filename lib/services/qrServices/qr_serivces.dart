import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';
import 'package:qr_bar_code/qr/src/qr_version.dart';
import 'package:qr_bar_code/qr/src/types.dart';

class QrCodeGenerator extends StatefulWidget {
  final double size;
  const QrCodeGenerator({super.key, this.size = 280});

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  late double size;
  @override
  void initState() {
    super.initState();
    size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QRCode(
              data: '',
              version: QRVersion.auto,
              size: size,
              backgroundColor: Colors.cyan,
              embeddedImage: const AssetImage('assets/logo.png'),
              embeddedImageStyle:
                  const QREmbeddedImageStyle(size: Size(100, 100)),
            ),
          ),
        ],
      ),
    );
  }
}
