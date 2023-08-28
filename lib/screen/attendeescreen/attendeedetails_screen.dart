import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/screen/attendeescreen/attendeedetails_view.dart';
import 'package:flutter/material.dart';

class AttendeeDetailsScreen extends StatelessWidget {
  final Attendee attendee;
  const AttendeeDetailsScreen({
    super.key,
    required this.attendee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(attendee.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AttendeeDetailsView(user: attendee),
        ),
      ),
    );
  }
}
