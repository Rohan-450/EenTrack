import 'package:eentrack/models/attendee_model.dart';
import 'package:flutter/material.dart';

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  final Function(Attendee)? onTap;
  const AttendeeCard({
    super.key,
    required this.attendee,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(attendee.name),
        leading: CircleAvatar(
          child: Text(attendee.name[0]),
        ),
        subtitle: Wrap(
          children: [
            StatusIndicator(
              label: 'Entry',
              status: attendee.isPresent,
            ),
            const SizedBox(width: 10),
            StatusIndicator(
              label: 'Exit',
              status: attendee.isLeft,
            ),
          ],
        ),
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  final String label;
  final bool status;
  const StatusIndicator({super.key, required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(width: 10),
        Icon(
          status ? Icons.check : Icons.close,
          color: status ? Colors.green : Colors.red,
        )
      ],
    );
  }
}
