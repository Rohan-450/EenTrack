import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/screen/meeting_details_screen/components/attendee_card.dart';
import 'package:flutter/material.dart';

class AttendeeSliverList extends StatelessWidget {
  final List<Attendee> attendees;
  final Function(Attendee)? onTap;
  const AttendeeSliverList({super.key, required this.attendees, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return AttendeeCard(
          attendee: attendees[index],
          onTap: onTap,
        );
      },
      itemCount: attendees.length,
    );
  }
}
