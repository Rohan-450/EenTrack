import 'dart:convert';

import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/meetingdetailsscreen/meeting_details_view.dart';
import 'package:eentrack/services/exportservice/export_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

import '../../services/dbservice/db_model.dart';

class MeetingDetailsScreen extends StatefulWidget {
  final Meeting meeting;
  final DBModel dbprovider;
  const MeetingDetailsScreen({
    super.key,
    required this.meeting,
    required this.dbprovider,
  });

  @override
  State<MeetingDetailsScreen> createState() => _MeetingDetailsScreenState();
}

class _MeetingDetailsScreenState extends State<MeetingDetailsScreen> {
  var entry = true;

  @override
  Widget build(BuildContext context) {
    var exportprovider = ExportService();
    var scanner = QrBarCodeScannerDialog();

    void handOver() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hand Over Meeting'),
              content: SizedBox(
                width: 300,
                child: QRCode(
                  data: jsonEncode(
                    widget.meeting.toMap(),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          });
    }

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

            widget.dbprovider
                .isAttendee(
                    widget.meeting.hostid, widget.meeting.id, attendee.uid)
                .then((exists) {
              if (exists) {
                if (entry) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Attendee already added'),
                    ),
                  );
                  return;
                }
                if (attendee.leftOn != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Attendee already left'),
                    ),
                  );
                  return;
                }
                attendee.leftOn = DateTime.now();
                try {
                  widget.dbprovider.updateAttendee(
                      widget.meeting.hostid, widget.meeting.id, attendee);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something went wrong'),
                    ),
                  );
                }
              }
              widget.dbprovider.addAttendee(
                  widget.meeting.hostid, widget.meeting.id, attendee);
            });
          });
    }

    void toggleEntry() {
      setState(() {
        entry = !entry;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          entry ? "Scan to make entry" : "Scan to make exit",
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting.title),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.file_upload_outlined,
              ),
              onPressed: () async {
                var attendees = await widget.dbprovider
                    .getAttendeesList(widget.meeting.hostid, widget.meeting.id);
                var filename = widget.meeting.title
                    .trim()
                    .toLowerCase()
                    .replaceAll(' ', '_');
                await exportprovider.toExcel(filename, attendees);
              }),
          // IconButton(
          //     icon: const Icon(
          //       Icons.delete_outlined,
          //     ),
          //     onPressed: () {
          //       showAlartDialog('Delete Meeting',
          //               'You sure want to delete the meeting?', context)
          //           .then((value) => {
          //                 if (value == Option.ok)
          //                   {
          //                     widget.dbprovider
          //                         .deleteMeeting(
          //                             widget.meeting.hostid, widget.meeting.id)
          //                         .then((value) => {
          //                               Navigator.of(context).pop(),
          //                             }),
          //                   }
          //               });
          //     }),

          IconButton(
            icon: const Icon(
              Icons.qr_code_outlined,
            ),
            onPressed: handOver,
          ),
        ],
      ),
      body: StreamBuilder<List<Attendee>>(
          stream: widget.dbprovider
              .getAttendees(widget.meeting.hostid, widget.meeting.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            var attendees = snapshot.data!;
            return MeetingDetailsView(
              meeting: widget.meeting,
              entry: entry,
              attendees: attendees,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: scanQrCode,
        child: GestureDetector(
          onLongPress: toggleEntry,
          child: const Icon(Icons.qr_code_outlined),
        ),
      ),
    );
  }
}
