import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/meetingdetailsscreen/meeting_details_view.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Details'),
      ),
      body: MeetingDetailsView(
        meeting: meeting,
        dbprovider: dbprovider,
      ),
    );
  }
}
