import 'package:flutter/material.dart';
import 'package:project_f/screen/authscreens/shared/custombuttons.dart';

import '../../services/qrServices/qr_serivces.dart';

class NewMeetingScreen extends StatelessWidget {
  NewMeetingScreen({Key? key}) : super(key: key);

  final List<String> eventList = ['Event 1', 'Event 2', 'Event 3'];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> showAllertDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Enter Meeting Details',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: descriptionController,
                  maxLines: null,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Your Past Meetings',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        showAllertDialogBox(context);
                      },
                      child: Card(
                        child: ListTile(
                          textColor: Colors.cyan,
                          leading: const Icon(Icons.person),
                          title: Text(eventList[index]),
                          subtitle: const Text('Meeting Date'),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
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
        ),
      ],
    );
  }
}
