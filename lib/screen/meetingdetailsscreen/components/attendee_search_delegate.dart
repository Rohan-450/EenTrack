import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/screen/meetingdetailsscreen/components/attendee_card.dart';
import 'package:flutter/material.dart';

class AttendeeSearchDelegate extends SearchDelegate {
  final List<Attendee> attendees;

  AttendeeSearchDelegate(this.attendees);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildAttendeeList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildAttendeeList(context);
  }

  Widget _buildAttendeeList(BuildContext context) {
    final List<Attendee> filteredAttendees = query.isEmpty
        ? attendees
        : attendees
            .where((attendee) =>
                attendee.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredAttendees.length,
      itemBuilder: (context, index) {
        final attendee = filteredAttendees[index];

        return AttendeeCard(attendee: attendee);
      },
    );
  }
}
