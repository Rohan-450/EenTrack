import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/dialog/alart_dialog.dart';
import 'package:eentrack/screen/meetingdetailsscreen/meeting_details_view.dart';
import 'package:eentrack/services/exportservice/export_service.dart';
import 'package:flutter/material.dart';

import '../../services/dbservice/db_model.dart';

class MeetingDetailsScreen extends StatelessWidget {
  final Meeting meeting;
  final DBModel dbprovider;
  const MeetingDetailsScreen({
    super.key,
    required this.meeting,
    required this.dbprovider,
  });

  @override
  Widget build(BuildContext context) {
    var exportprovider = ExportService();

    return Scaffold(
      appBar: AppBar(
        title: Text(meeting.title),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.file_upload_outlined,
              ),
              onPressed: () async {
                var attendees = await dbprovider.getAttendeesList(
                    meeting.hostid, meeting.id);
                var filename =
                    meeting.title.trim().toLowerCase().replaceAll(' ', '_');
                await exportprovider.toExcel(filename, attendees);
              }),
          IconButton(
              icon: const Icon(
                Icons.delete_outlined,
              ),
              onPressed: () {
                showAlartDialog('Delete Meeting',
                        'You sure want to delete the meeting?', context)
                    .then((value) => {
                          if (value == Option.ok)
                            {
                              dbprovider
                                  .deleteMeeting(meeting.hostid, meeting.id)
                                  .then((value) => {
                                        Navigator.of(context).pop(),
                                      }),
                            }
                        });
              }),
        ],
      ),
      body: MeetingDetailsView(
        meeting: meeting,
        dbprovider: dbprovider,
      ),
    );
  }
}
