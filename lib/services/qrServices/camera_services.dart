import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class CameraSrevices extends StatefulWidget {
  const CameraSrevices({Key? key}) : super(key: key);

  @override
  State<CameraSrevices> createState() => _CameraSrevicesState();
}

class _CameraSrevicesState extends State<CameraSrevices> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  bool _isScanning = false;

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
        body: IconButton(
            onPressed: () {
              _openCameraAndScan();
            },
            icon: const Icon(Icons.qr_code_scanner_rounded)));
  }
}
