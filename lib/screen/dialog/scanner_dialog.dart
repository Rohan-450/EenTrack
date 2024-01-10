import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> showScannerDialog({
  required BuildContext context,
  required String title,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 200,
          height: 200,
          child: MobileScanner(
            onDetect: (barcodeScan) {
              var codes = barcodeScan.barcodes;
              var rawCodes = codes
                  .map((e) => e.rawValue)
                  .where(
                    (e) => e != null,
                  )
                  .toList();
              if (rawCodes.isNotEmpty) {
                Navigator.of(context).pop(rawCodes[0]);
              }
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
