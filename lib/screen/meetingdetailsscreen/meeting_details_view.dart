import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/attendeescreen/attendeedetails_screen.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MeetingDetailsView extends StatelessWidget {
  final Meeting meeting;
  final DBModel dbprovider;
  final bool entry;

  const MeetingDetailsView({
    super.key,
    required this.meeting,
    required this.dbprovider,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
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
          )),
          StreamBuilder<List<Attendee>>(
              stream: dbprovider.getAttendees(meeting.hostid, meeting.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(),
                  );
                }
                var attendees = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: attendees.length,
                    (context, index) {
                      return AttendeeCard(
                        attendee: attendees[index],
                        onTap: (attendee) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AttendeeDetailsScreen(
                                attendee: attendee,
                              ),
                            ),
                          );
                        },
                      ).animate().slideX().fadeIn();
                    },
                  ),
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
