import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';
import 'package:qr_bar_code/qr/src/qr_version.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: QRCode(
            data: '${meeting.id}@${meeting.hostid}',
            version: QRVersion.auto,
            size: 280,
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
          child: StreamBuilder<List<Attendee>>(
              stream: dbprovider.getAttendees(meeting.hostid, meeting.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                var attendees = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: attendees.length,
                  itemBuilder: ((context, index) {
                    return AttendeeCard(
                      attendee: attendees[index],
                    );
                  }),
                );
              }),
        )
      ],
    );
  }
}

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  const AttendeeCard({super.key, required this.attendee});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
