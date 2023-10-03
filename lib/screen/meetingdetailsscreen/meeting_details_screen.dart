import 'dart:convert';

import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/dialog/alart_dialog.dart';
import 'package:eentrack/screen/meetingdetailsscreen/meeting_details_view.dart';
import 'package:eentrack/services/exportservice/export_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

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
    var scanner = QrBarCodeScannerDialog();

    bool validateMap(Map<String, dynamic> data) {
      var validKeys = [
        'uid',
        'name',
        'rollNo',
        'semester',
        'department',
        'email',
        'linkedin',
        'github'
      ];
      for (var key in validKeys) {
        if (!data.containsKey(key)) {
          return false;
        }
      }
      return true;
    }

    void scanQrCode() {
      scanner.getScannedQrBarCode(
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
            Map<String, dynamic> data = jsonDecode(code);
            if (!validateMap(data)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid QR Code'),
                ),
              );
              return;
            }
            var attendee = Attendee(
              uid: data['uid'],
              name: data['name'],
              roll: data['rollNo'],
              semester: data['semester'],
              department: data['department'],
              email: data['email'],
              linkedin: data['linkedin'],
              github: data['github'],
              addedOn: DateTime.now(),
            );

            dbprovider.isAttendee(meeting.hostid, meeting.id, attendee.uid).then((exists) {
              if (exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attendee already added'),
                  ),
                );
                return;
              }
              dbprovider.addAttendee(meeting.hostid, meeting.id, attendee);
            });
          });
    }

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
      floatingActionButton: FloatingActionButton(
        onPressed: scanQrCode,
        child: const Icon(Icons.qr_code_outlined),
      ),
    );
  }
}
