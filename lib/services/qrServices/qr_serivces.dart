import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';
import 'package:qr_bar_code/qr/src/qr_version.dart';

class QrCodeGenerator extends StatefulWidget {
  final double size;
  const QrCodeGenerator({Key? key, this.size = 280}) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  final List<String> itemlist = [
    'Nabajit',
    'Jhutiwala Gandu',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
    'Rohan Gay',
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
        centerTitle: true,
        title: const Text('Scanner Screen'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.file_upload_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: size,
            flexibleSpace: Center(
              child: QRCode(
                data: '',
                version: QRVersion.auto,
                size: size,
                backgroundColor: Colors.cyan,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Scan this QR to get registered in the meeting',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                Text('Current Participants'),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: ListTile(
                    title: Title(
                      color: Colors.blue,
                      child: Text(itemlist[index]),
                    ),
                    subtitle: const Text('2nd Year'),
                    trailing: const Text(
                      '16900122180',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
              childCount: itemlist.length,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: QrCodeGenerator(),
  ));
}
