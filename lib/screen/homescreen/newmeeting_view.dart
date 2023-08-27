import 'package:flutter/material.dart';

import '../authscreens/shared/custombuttons.dart';

class NewMeetingView extends StatelessWidget {
  NewMeetingView({Key? key}) : super(key: key);

  final List<String> eventList = ['Event 1', 'Event 2', 'Event 3'];

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
                        // TODO: Show meeting details
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
                // TODO: Add new meeting
              },
            ),
          ),
        ),
      ],
    );
  }
}
