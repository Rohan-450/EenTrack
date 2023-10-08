import 'dart:convert';

import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/screen/dialog/meetingdetails_dialog.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

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
    void showMeetingForm() {
      showMeetingFormDialog(context, user.uid).then((value) {
        if (value != null) {
          dbprovider.createMeeting(user.uid, value).then((value) => {
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
    }

    bool validateMeeting(Map<String, dynamic> data) {
      var validKeys = ['id', 'hostid', 'title', 'description', 'date'];
      for (var key in validKeys) {
        if (!data.containsKey(key)) {
          return false;
        }
      }
      return true;
    }

    void takeOver() {
      QrBarCodeScannerDialog().getScannedQrBarCode(
          context: context,
          onCode: (code) {
            if (code == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid QR Code'),
                ),
              );
              return;
            }
            var meetingJson = jsonDecode(code);
            if (!validateMeeting(meetingJson)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid QR Code'),
                ),
              );
              return;
            }
            var meeting = Meeting.fromMap(meetingJson);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MeetingDetailsScreen(
                  meeting: meeting,
                  dbprovider: dbprovider,
                ),
              ),
            );
          });
    }

    return Animate(
      child: Stack(
        children: [
          OldMeetingsList(dbprovider: dbprovider, user: user),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 37, 39, 0.6),
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            textColor: Theme.of(context).colorScheme.primary,
                            text: 'Take Over',
                            onPressed: takeOver,
                          ),
                        ),
                        const VerticalDivider(
                          thickness: 1,
                        ),
                        Expanded(
                          child: CustomTextButton(
                            text: 'New Meeting',
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            onPressed: showMeetingForm,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OldMeetingsList extends StatelessWidget {
  const OldMeetingsList({
    super.key,
    required this.dbprovider,
    required this.user,
  });

  final DBModel dbprovider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                var meeting = meetings[index];
                return Dismissible(
                  key: Key(meeting.id),
                  onDismissed: (_) {
                    dbprovider.deleteMeeting(meeting.hostid, meeting.id).then(
                          (_) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Meeting Deleted'),
                            ),
                          ),
                        );
                  },
                  child: MeetingTile(
                    meeting: meeting,
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
                  ).animate().slideX().fadeIn(),
                );
              },
            );
          }),
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
