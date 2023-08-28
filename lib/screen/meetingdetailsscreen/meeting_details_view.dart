import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/attendeescreen/attendeedetails_screen.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';

class MeetingDetailsView extends StatelessWidget {
  final Meeting meeting;
  final DBModel dbprovider;
  const MeetingDetailsView({
    super.key,
    required this.meeting,
    required this.dbprovider,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [ShimmerEffect()],
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  QRCode(
                    data: '${meeting.hostid}@${meeting.id}',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scan this QR to get registered in the meeting',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(height: 20),
          //       Text(
          //         'Scan this QR to get registered in the meeting',
          //         style: TextStyle(
          //           fontWeight: FontWeight.w700,
          //           fontSize: 15,
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       Text('Current Participants'),
          //     ],
          //   ),
          // ),
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
