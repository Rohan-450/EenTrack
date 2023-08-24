import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class CameraSrevices extends StatefulWidget {
  const CameraSrevices({Key? key}) : super(key: key);

  @override
  _CameraSrevicesState createState() => _CameraSrevicesState();
}

class _CameraSrevicesState extends State<CameraSrevices> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  bool _isScanning = false; // Track if scanning process has started

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (!_isScanning) {
          _openCameraAndScan();
          _isScanning = true;
        }
      },
    );
  }

  void _openCameraAndScan() async {
    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
      context: context,
      onCode: (code) {
        setState(() {
          this.code = code;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(code ?? 'Scanning...'),
      ),
    );
  }
}
