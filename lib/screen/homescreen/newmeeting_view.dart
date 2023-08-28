import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/screen/dialog/meetingdetails_dialog.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../authscreens/shared/custombuttons.dart';
import '../meetingdetailsscreen/meeting_details_screen.dart';

class NewMeetingView extends StatelessWidget {
  final User user;
  final DBModel dbprovider;
  const NewMeetingView({
    Key? key,
    required this.user,
    required this.dbprovider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: StreamBuilder<List<Meeting>>(
                stream: dbprovider.getMeetings(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  var meetings = snapshot.data!;
                  return ListView.builder(
                    itemCount: meetings.length,
                    itemBuilder: (BuildContext context, index) {
                      return MeetingTile(
                        meeting: meetings[index],
                        onTap: (meeting) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MeetingDetailsScreen(
                                meeting: meeting,
                                dbprovider: dbprovider,
                              ),
                            ),
                          );
                        },
                      ).animate().slideX().fadeIn();
                    },
                  );
                }),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: CustomElevatedButton(
                text: 'New Meeting',
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  showMeetingFormDialog(context, user.uid).then((value) {
                    if (value != null) {
                      dbprovider
                          .createMeeting(user.uid, value)
                          .then((value) => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MeetingDetailsScreen(
                                      meeting: value,
                                      dbprovider: dbprovider,
                                    ),
                                  ),
                                )
                              });
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeetingTile extends StatelessWidget {
  final Meeting meeting;
  final Function(Meeting) onTap;
  const MeetingTile({super.key, required this.meeting, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm a');
    return GestureDetector(
      onTap: () => onTap(meeting),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(meeting.title),
          subtitle: Text(formatter.format(meeting.date)),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
