import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/screen/meetingdetailsscreen/components/attendee_card.dart';
import 'package:flutter/material.dart';

class AttendeeSliverList extends StatelessWidget {
  final List<Attendee> attendees;
  const AttendeeSliverList({super.key, required this.attendees});

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      itemBuilder: (context, index, animation) {
        return AttendeeCard(
          attendee: attendees[index],
          onTap: (a) {},
        );
      },
      initialItemCount: attendees.length,
    );
  }
}
