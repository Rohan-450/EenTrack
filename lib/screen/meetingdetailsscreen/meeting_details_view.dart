import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/attendeescreen/attendeedetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MeetingDetailsView extends StatelessWidget {
  final Meeting meeting;
  final List<Attendee> attendees;
  final bool entry;

  const MeetingDetailsView({
    super.key,
    required this.meeting,
    required this.attendees,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    var leftAttendees =
        attendees.where((element) => element.leftOn != null).toList();
    return Animate(
      effects: const [ShimmerEffect()],
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Card(
              child: ListTile(
                title: Text(meeting.title),
                subtitle: Text(meeting.description),
                trailing: entry
                    ? const Icon(Icons.check_box_outline_blank_rounded)
                    : const Icon(Icons.check_box_outlined),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: leftAttendees.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Left Attendees : ${leftAttendees.length}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
          ),
          SliverList.builder(
              itemCount: leftAttendees.length,
              itemBuilder: (context, index) {
                return AttendeeCard(
                  attendee: leftAttendees[index],
                  onTap: (attendee) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendeeDetailsScreen(
                          attendee: attendee,
                        ),
                      ),
                    );
                  },
                );
              }),
          SliverToBoxAdapter(
            child: Visibility(
              visible: attendees.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Attendees : ${attendees.length}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
          ),
          SliverList.builder(
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                return AttendeeCard(
                  attendee: attendees[index],
                  onTap: (attendee) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendeeDetailsScreen(
                          attendee: attendee,
                        ),
                      ),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  final Function(Attendee) onTap;
  const AttendeeCard({
    super.key,
    required this.attendee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(attendee),
      child: Card(
        child: ListTile(
          title: Title(
              color: Colors.blue,
              child: Text(
                attendee.name,
              )),
          subtitle: Text(attendee.semester),
          trailing: Text(
            attendee.roll,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
