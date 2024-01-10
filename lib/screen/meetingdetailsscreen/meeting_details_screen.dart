import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/export_fields.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/dialog/alart_dialog.dart';
import 'package:eentrack/screen/meetingdetailsscreen/components/co_host_manager.dart';
import 'package:eentrack/screen/meetingdetailsscreen/meeting_details_view.dart';
import 'package:eentrack/screen/scanning_screen/scanning_screen.dart';
import 'package:eentrack/services/exportservice/export_service.dart';
import 'package:flutter/material.dart';

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
  var exportprovider = ExportService();
  List<Attendee> attendees = [];

  void _deleteMeeting() async {
    var result = await showAlartDialog(
        'Delete Meeting', 'You sure want to delete meeting?', context);
    if (result != Option.ok) return;
    await widget.dbprovider
        .deleteMeeting(widget.meeting.hostid, widget.meeting.id);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  void _exportToExcel() {
    exportprovider.toExcel(widget.meeting.title, attendees, [
      ExportField.uid,
      ExportField.name,
      ExportField.addedOn,
      ExportField.leftOn,
      ExportField.attendedFullMeeting,
    ]);
  }

  void _scanAttendee() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScanningScreen(
          dbprovider: widget.dbprovider,
          meeting: widget.meeting,
        ),
      ),
    );
  }

  void _addCohost() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          CoHostManager(meeting: widget.meeting, db: widget.dbprovider),
    );
  }

  List<Widget> _buildActions() {
    if (widget.meeting.isHost) {
      return [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: _exportToExcel,
        ),
        IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: _addCohost,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _deleteMeeting,
        ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting.title),
        actions: _buildActions(),
      ),
      body: StreamBuilder<List<Attendee>>(
          stream: widget.dbprovider
              .getAttendees(widget.meeting.hostid, widget.meeting.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LinearProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            attendees = snapshot.data!;
            return MeetingDetailsView(
              meeting: widget.meeting,
              entry: entry,
              attendees: attendees,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanAttendee,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
