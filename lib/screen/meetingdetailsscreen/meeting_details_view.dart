import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/meeting_model.dart';
import 'package:eentrack/screen/meetingdetailsscreen/components/attendee_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AttendeeFilter {
  present,
  left,
}

class MeetingDetailsView extends StatefulWidget {
  final Meeting meeting;
  final List<Attendee> attendees;
  final bool entry;

  const MeetingDetailsView({
    super.key,
    required this.meeting,
    required this.attendees,
    required this.entry,
  });

  @override
  State<MeetingDetailsView> createState() => _MeetingDetailsViewState();
}

class _MeetingDetailsViewState extends State<MeetingDetailsView> {
  Map<AttendeeFilter, bool> filter = {
    AttendeeFilter.present: false,
    AttendeeFilter.left: false,
  };

  List<Attendee> get filteredAttendees {
    var filtered = widget.attendees;
    for (var key in filter.keys) {
      if (filter[key]!) {
        switch (key) {
          case AttendeeFilter.present:
            filtered = filtered.where((element) => element.isPresent).toList();
            break;
          case AttendeeFilter.left:
            filtered = filtered.where((element) => element.isLeft).toList();
            break;
        }
      }
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Wrap(
              children: AttendeeFilter.values
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ChoiceChip(
                        label: Text(e.name),
                        selected: filter[e] ?? false,
                        onSelected: (value) =>
                            setState(() => filter[e] = !filter[e]!),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total: ${filteredAttendees.length}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: AttendeeSliverList(
              attendees: filteredAttendees,
            ),
          )
        ],
      ),
    );
  }
}
