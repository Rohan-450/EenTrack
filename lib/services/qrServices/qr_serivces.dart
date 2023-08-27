import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';
import 'package:qr_bar_code/qr/src/qr_version.dart';

class QrCodeGenerator extends StatefulWidget {
  final double size;
  const QrCodeGenerator({super.key, this.size = 280});

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  final List<String> itemlist = [
    'Nabajit',
    'Jhutiwala Gandu',
    'Rohan Gay',
    'Anjishnu',
    'Meeting ',
  ];
  late double size;
  @override
  void initState() {
    super.initState();
    size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanner Screen'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.file_upload_outlined),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: QRCode(
                data: '',
                version: QRVersion.auto,
                size: size,
                backgroundColor: Colors.cyan,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Scan this QR to get registered in the meeting',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Current Participants'),
            const SizedBox(
              height: 20,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: ListView.builder(
                itemCount: itemlist.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Title(
                          color: Colors.blue,
                          child: Text(
                            itemlist[index],
                          )),
                      subtitle: const Text('2nd Year'),
                      trailing: const Text(
                        '16900122180',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ));
  }
}
